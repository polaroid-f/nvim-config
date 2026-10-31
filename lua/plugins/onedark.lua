return{
  -- Using Lazy
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'warmer' -- change color here
		-- dark, darker, cool, deep, warm, warmer, light
      }
      require('onedark').load()
    end
  }
}

