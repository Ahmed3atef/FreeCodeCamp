test_settings = {'theme': 'light', 'dark-mode': 'off', 'language': 'en'}


def add_setting(input_dict, pair):

    key = pair[0].lower()
    value = pair[1].lower()

    if key in input_dict:
        return f"Setting '{key}' already exists! Cannot add a new setting with this name."
    else:
        input_dict[key] = value
        return f"Setting '{key}' added with value '{value}' successfully!"


def update_setting(input_dict, pair):
    key = pair[0].lower()
    value = pair[1].lower()

    if input_dict.get(key):
        input_dict[key] = value
        return f"Setting '{key}' updated to '{value}' successfully!"
    else:
        return f"Setting '{key}' does not exist! Cannot update a non-existing setting."


def delete_setting(input_dict, key):
    key = key.lower()

    if key in input_dict.keys():
        input_dict.pop(key)
        return f"Setting '{key}' deleted successfully!"
    else:
        return "Setting not found!"


def view_settings(input_dict):

    if not input_dict:
       return "No settings available."
    else:
        returned_string = "Current User Settings:\n"
        for key, value in input_dict.items():
            returned_string += f"{key.capitalize()}: {value}\n"
        return returned_string
