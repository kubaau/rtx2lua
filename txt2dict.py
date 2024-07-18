# 2 bytes           0xE7FD (File Identifier)
# 2 bytes           count (number of texts)
# 2 bytes           Unknown data
# 2 bytes           size (size of data without header)

# Now come the starting offsets of the texts:
# count*2 bytes     offset (start offsets)

# Now the texts follow, if the offset is 0, the text entry is unused.

# It is best to go through all offsets, add 10 to the offset and
# you get the start address of the text.
# This is read in up to the terminating '\0'.

bytes_read = 0

def read_next_int(data, count):
    global bytes_read
    ret = int.from_bytes(data[bytes_read : bytes_read + count], byteorder='little')
    bytes_read += count
    return ret

def read_until_null(data, begin):
    if begin >= len(data): # the offsets may be wrongly configured to point beyond data
        return []

    end = begin
    while data[end]:
        end = end + 1
    return data[begin : end]

def decode(text, encoding):
    return bytes(text).decode(encoding).replace('@', '\n')

def get_text_count(data):
    file_id = read_next_int(data, 2)
    # print("file_id =", hex(file_id))
    text_count = read_next_int(data, 2)
    # print(f'{text_count = }')
    unknown_data = read_next_int(data, 2)
    # print("file_id =", hex(unknown_data))
    size_of_data_without_header = read_next_int(data, 2)
    # print(f'{size_of_data_without_header = }')
    return text_count

def get_offsets(data):
    # offsets = []
    offsets_non_zero = {}

    for i in range(get_text_count(data)):
        offset = read_next_int(data, 2)
        # offsets.append(offset)
        if offset:
            offsets_non_zero.update({i: offset})

    # print("offsets:")
    # for i in range(len(offsets)):
    #     print("{:>3} {:>6}".format(i, offsets[i]), end = "\t\t")
    #     if i % 8 == 7:
    #         print()
    #     if offsets[i]:
    #         offsets_non_zero.update({i: offsets[i]})
    # print()

    # print(f'{offsets_non_zero = }')
    return offsets_non_zero

def txt2dict(file, encoding):
    global bytes_read

    ret = {}

    data = file.read_bytes()
    bytes_read = 0
    last_read_byte = 0
    msg_id = 0
    offsets = get_offsets(data)

    for k in offsets.keys():
        begin = offsets[k] + 10
        text = read_until_null(data, begin)
        last_read_byte = begin + len(text) + 1
        decoded_text = decode(text, encoding)
        if decoded_text:
            decoded_text_repr = repr(decoded_text)
            if msg_id % 2 == 0:
                # print("\nmsg{} = {}".format(msg_id, decoded_text_repr))
                ret.update({"msg{}".format(msg_id): decoded_text_repr})
            else:
                # print("msgh{} = {}".format(msg_id - 1, decoded_text_repr))
                ret.update({"msgh{}".format(msg_id - 1): decoded_text_repr})
        msg_id = msg_id + 1

    # weird MISS_001 msg100 case - read two more texts
    if last_read_byte < len(data):
        text = read_until_null(data, last_read_byte)
        # print("\nmsg100 = {}".format(repr(decode(text, encoding))))
        ret.update({"msg100": repr(decode(text, encoding))})
        text = read_until_null(data, last_read_byte + len(text) + 1)
        # print("msgh100 = {}".format(repr(decode(text, encoding))))
        ret.update({"msgh100": repr(decode(text, encoding))})
    
    return ret

# from pathlib import Path
# import sys

# file = Path(sys.argv[1])

# encoding = "cp1250"
# if file.suffix.lower() == ".ger":
#     encoding = "cp852"

# ret = txt2dict(file, encoding)

# if os.name == "nt":
#     sys.stdout.reconfigure(encoding="utf-8")
# for key, value in ret.items():
#     print("{:7} = {}".format(key, value), end = ",\n")
