--
-- EPITECH PROJECT, 2023
-- lvim
-- File description:
-- headers.lua
--

local HF_TEMPLATE =
{"/*",
 "** EPITECH PROJECT, %d",
 "** %s",
 "** File description:",
 "** %s",
 "*/",
 "",
 "#ifndef %s",
 "\t#define %s",
 "",
 "#endif /* !%s */"}

local HASH_LIKE_HEADER_TEMPLATE =
{"##",
 "## EPITECH PROJECT, %d",
 "## %s",
 "## File description:",
 "## %s",
 "##",
 "",}

local STAR_LIKE_HEADER_TEMPLATE =
{"/*",
 "** EPITECH PROJECT, %d",
 "** %s",
 "** File description:",
 "** %s",
 "*/",
 "",}

local DASH_LIKE_HEADER_TEMPLATE =
{"--",
 "-- EPITECH PROJECT, %d",
 "-- %s",
 "-- File description:",
 "-- %s",
 "--",
 "",}

local set_dir = function()
    if (os.execute('git rev-parse --is-inside-work-tree &> /dev/null') ~= 0) then
        return vim.loop.cwd()
    end
    for dir in io.popen("git rev-parse --show-toplevel"):lines() do
        return dir
    end
end

local get_extension = function()
    local file_name = vim.api.nvim_buf_get_name(0)
    local extension = ""

    file_name = string.reverse(file_name)
    for i = 1, #file_name do
        local char = file_name:sub(i, i)
        if (char == '.' or char == '/') then
            break;
        end
        extension = extension .. char
    end
    extension = string.reverse(extension)
    return extension
end

local format_for_header = function(file_name)
    file_name = string.upper(file_name)

    file_name = file_name.gsub(file_name, "%.", "_")
    file_name = file_name .. "_"
    return file_name
end

local insert_header_from_template = function(template)
    local year = os.date("%Y")
    local working_dir = set_dir()
    local file_name = vim.api.nvim_buf_get_name(0)
    local final_dir = ""

    -- Get file_name and formatted_name for .h files
    local t={}
    for str in string.gmatch(file_name, "([^".."/".."]+)") do
        table.insert(t, str)
    end
    file_name = t[#t]
    local formatted_name = format_for_header(file_name)

    -- Parse proper working_dir
    if (working_dir ~= nil) then
        t={}
        for str in string.gmatch(working_dir, "([^".."/".."]+)") do
            final_dir = str
        end
    else
        final_dir = "Unknown"
    end

    template[2] = string.format(template[2], year)
    template[3] = string.format(template[3], final_dir)
    template[5] = string.format(template[5], file_name)
    if (template == HF_TEMPLATE) then
        template[8] = string.format(template[8], formatted_name)
        template[9] = string.format(template[9], formatted_name)
        template[11] = string.format(template[11], formatted_name)
    end
    vim.api.nvim_buf_set_lines(0, 0, 0, false, template)
end

local insert_header = function()
    local file_type = get_extension()

    if (file_type == "sh" or file_type == "py" or file_type == "Makefile") then
        insert_header_from_template(HASH_LIKE_HEADER_TEMPLATE)
    elseif(file_type == "h") then
        insert_header_from_template(HF_TEMPLATE)
    elseif (file_type == 'c' or file_type == 'cpp') then
        insert_header_from_template(STAR_LIKE_HEADER_TEMPLATE)
    elseif (file_type == 'lua') then
        insert_header_from_template(DASH_LIKE_HEADER_TEMPLATE)
    else
        print("File extension not supported, implement your own in ~/.config/lvim/lua/headers.lua.")
    end
end

return {
    insert_header = insert_header
}
