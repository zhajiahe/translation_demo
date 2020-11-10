## utils
import jionlp as jio

def load_case_model(path):
    lines = jio.read_file_by_line(path)
    case_dict = {}
    for line in lines:
        content = line.split()
        if len(content) == 2:
            continue
        key, value = content[0].lower(), content[0]
        case_dict[key] = value
    return case_dict

def load_user_dict(path):
    lines = jio.read_file_by_line(path)
    user_dict = {
            }
    for line in lines:
        content = line.split('\t')
        user_dict[content[0]] = content[1]

    return user_dict
