return {
  {
    'chrisgrieser/nvim-genghis',
    config = function()
      require('genghis').setup {
        fileOperations = {
          autoAddExt = true,

          trashCmd = function() ---@type fun(): string|string[]
            if jit and jit.os == 'OSX' then
              return 'trash'
            end -- builtin since macOS 14
            if jit and jit.os == 'Windows' then
              return 'trash'
            end
            if jit and jit.os == 'Linux' then
              return { 'gio', 'trash' }
            end
            return 'trash-cli'
          end,

          ignoreInFolderSelection = {
            '/node_modules/',
            '/typings/',
            '/doc/',
            '%.app/',
            '/%.',
          },
        },

        navigation = {
          onlySameExtAsCurrentFile = false,
          ignoreDotfiles = true,
          ignoreExt = { 'png', 'svg', 'webp', 'jpg', 'jpeg', 'gif', 'pdf', 'zip' },
          ignoreFilesWithName = { '.DS_Store' },
        },

        successNotifications = true,

        icons = {
          chmodx = '󰒃',
          copyFile = '󱉥',
          copyPath = '󰅍',
          duplicate = '',
          file = '󰈔',
          move = '󰪹',
          new = '󰝒',
          nextFile = '󰖽',
          prevFile = '󰖿',
          rename = '󰑕',
          trash = '󰩹',
        },
      }
    end,
  },
}
