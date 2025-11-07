# Slimcoin Static Build Guide (Linux)

This guide describes how to build a completely statically linked `slimcoind` binary.
The build process uses private static copies of the required dependencies:

- Boost 1.57
- BerkeleyDB 4.8
- OpenSSL 1.0.2
- miniUPnPc 1.6

No system-wide library installations are required.
The resulting binary can run on most modern Linux systems without additional packages. However, it requires gcc-12. gcc-14 is not supported at the moment.

## Requirements

Install minimal development tools:

```
sudo apt update
```
```
sudo apt install -y build-essential git automake autoconf libtool pkg-config curl wget zlib1g-dev
```

## Clone the Repository

```
git clone https://github.com/tedydet/Slimcoin.git
cd Slimcoin
git checkout static-linking-fix
```

## Build the Dependencies

The project uses the `depends/` system to build static vendor libraries:

```
cd depends

# Berkeley DB 4.8
make -C packages/db4 db4_stage

# open-ssl 1.0.2u
make -C packages/openssl openssl_stage

# Boost
make -C packages/boost boost_stage

# miniupnpc
make -C packages/miniupnpc miniupnpc_stage
```

The static libraries are installed into:
```
depends/work/stage-x86_64-linux-gnu/lib/
```

## Build Slimcoin Daemon

```
cd ../src
make -f makefile.unix USE_UPNP=0 -j$(nproc)
```

## Output

The resulting binary is located at:

```
src/slimcoind
```

To verify:

```
file src/slimcoind
```

A correct build should report a statically linked executable.

## Running Slimcoind

Initialize configuration:

```
mkdir -p ~/.slimcoin
nano ~/.slimcoin/slimcoin.conf
```

Example minimal `slimcoin.conf`:

```
rpcuser=slimrpc
rpcpassword=changethis
server=1
daemon=1
listen=1
```

Start:

```
~/Slimcoin/src/slimcoind
```

Follow logs:

```
tail -f ~/.slimcoin/debug.log
```

## Troubleshooting

| Issue | Solution |
|------|----------|
| Missing library errors | Ensure `depends` built successfully |
| SSL or RPC errors | Confirm `slimcoin.conf` is configured correctly |
| Port conflicts | Change RPC or P2P ports in configuration |

## Notes

This build is designed for static server deployment.
The standard Qt GUI wallet is not included in this configuration.

If you encounter build issues or want to contribute improvements, please open a pull request or report an issue on GitHub.
