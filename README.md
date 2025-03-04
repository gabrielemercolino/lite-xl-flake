# lite-xl-flake

## Idea

```nix
programs.lite-xl = {
    enable = true;

    # settings for the editor only, for the plugins settings check the plugins section
    settings = {};

    # like nvf
    languages = {
        #TODO: does it really make sense to not install the syntax for the enabled languages?
        sytnaxes.enable = true; # automatically adds the syntax highlighting for the enabled languages
        lsp.enable = true;      # automatically adds the lsp for the enabled languages

        nix = {
            enable = true;      # enables this specific language
            syntax = {
                enable = true;  # enables syntax for this specific language;
                                # if languages.syntaxes.enable is true and this is false it should not add the syntax
                package = null; # idk if package makes sense here, another idea might be to have a link to the syntax definition
            };

            lsp = {
                enable = true;  # same as syntax but for lsp server
                package = null; # here the package makes sense
            }
        };

        c.enable = true;        # here the syntax and lsp are installed only if the first two enables are true 
    };

    plugins = {
        console = {
            enable = true;      # adds the plugin
            package = null;     # the package to use
            settings = {};      # plugin related settings
        };
    };
};
```
