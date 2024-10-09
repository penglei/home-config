

## 可能出现的错误

1. 没有正确配置文件系统

    需要使用nixos-generate-config生成配置

    ```
    # nix shell nixpkgs#nixos-install-tools
    # nixos-generate-config
    writing /etc/nixos/hardware-configuration.nix...
    writing /etc/nixos/configuration.nix...
    For more hardware-specific settings, see https://github.com/NixOS/nixos-hardware.
    ```


1.  提示systemd-boot 不存在

    ```
    root@debian:~# /nix/var/nix/profiles/system/bin/switch-to-configuration boot
    systemd-boot not installed in ESP.
    Traceback (most recent call last):
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 435, in <module>
        main()
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 418, in main
        install_bootloader(args)
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 342, in install_bootloader
        raise Exception("could not find any previously installed systemd-boot")
    Exception: could not find any previously installed systemd-boot
    Failed to install bootloader
    ```

    这时候需要提前安装 systemd-boot，安装该组件时会拷贝相应的systemd-boot配置到 /boot/efi/EFI 中

    ```
    # apt install systemd-boot
    ```


2. 错误的profile history

    ```
    # /nix/var/nix/profiles/system/bin/switch-to-configuration boot
    failed to synthesize: failed to read /nix/store/c0dj6b3247lhr4y7vj1d54a7mfzx9iv2-profile/nixos-version: No such file or directory (os error 2)
    Traceback (most recent call last):
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 435, in <module>
        main()
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 418, in main
        install_bootloader(args)
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 365, in install_bootloader
        remove_old_entries(gens)
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 243, in remove_old_entries
        bootspec = get_bootspec(gen.profile, gen.generation)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 124, in get_bootspec
        boot_json_str = run(
                        ^^^^
      File "/nix/store/d04m4r8vrsajbkmzx2516sbbx0b8zgqj-systemd-boot/bin/systemd-boot", line 58, in run
        return subprocess.run(cmd, check=True, text=True, stdout=stdout)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/nix/store/6iq3nhgdyp8a5wzwf097zf2mn4zyqxr6-python3-3.12.5/lib/python3.12/subprocess.py", line 571, in run
        raise CalledProcessError(retcode, process.args,
    subprocess.CalledProcessError: Command '['/nix/store/s81fsw2cy7pmf72lc3agx70rmfmpii8r-bootspec-1.0.0/bin/synthesize', '--version', '1', '/nix/var/nix/profiles/system-16-link', '/dev/stdout']' returned non-zero exit status 1.
    Failed to install bootloader
    ```

    这个错误看起来是引用到了错误的system profile history，具体原因位置。使用如下命令清理之后就正常了

        # nix profile remove toplevel --profile /nix/var/nix/profiles/system
    `nix profile wipe-history --profile`

