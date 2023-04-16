<div align="center">

# asdf-ya [![Build](https://github.com/yhakbar/asdf-ya/actions/workflows/build.yml/badge.svg)](https://github.com/yhakbar/asdf-ya/actions/workflows/build.yml) [![Lint](https://github.com/yhakbar/asdf-ya/actions/workflows/lint.yml/badge.svg)](https://github.com/yhakbar/asdf-ya/actions/workflows/lint.yml)


[ya](https://github.com/yhakbar/ya) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add ya
# or
asdf plugin add ya https://github.com/yhakbar/asdf-ya.git
```

ya:

```shell
# Show all installable versions
asdf list-all ya

# Install specific version
asdf install ya latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ya latest

# Now ya commands are available
ya --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/yhakbar/asdf-ya/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Yousif Akbar](https://github.com/yhakbar/)
