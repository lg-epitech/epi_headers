[![forthebadge](https://forthebadge.com/images/featured/featured-compatibility-betamax.svg)](https://forthebadge.com)

[![forthebadge](https://forthebadge.com/images/badges/fuck-it-ship-it.svg)](https://forthebadge.com)
# epi_headers
Implementing ```epitech headers``` (POST 2017) for ```neovim``` **in lua**

## Installation
* You can install epi_headers using your own package manager!

Here is an **example** of how to set up epitech headers with ```lazy```

*This might be slightly different different in respect to the package manager you are using.*

```lua
-- init.lua
-- for lazy like implementation
...,
{
	"lg-epitech/epi_headers",
},
```

```lua
-- config.lua
-- You can now insert header with the "tek" motion (modifiable)
vim.cmd("nnoremap tek <cmd>lua require('headers').insert_header()<CR>")
```

* Updates will also be handled through your package manager of choice.

## Issues
If you encounter a problem using epi_headers, you can create your own issue on this repo explaining your problem.

If you are looking for support for other languages, you can also make an issue in the github and I will look into it. You can also probably do it yourself with the template, shouldn't be too hard.

## License
The MIT License (MIT) 2024 - [Laurent Gonzalez]("https://github.com/lg-epitech"). [LICENSE](LICENSE)