From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 07/22] kbuild: lto: merge module sections
Date: Wed, 24 Jun 2020 14:01:59 -0700
Message-ID: <CAKwvOdkY2M9+BgA5FELK+7bjv1sZYMuTmVOztCYijas_OHfVDQ@mail.gmail.com>
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-8-samitolvanen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200624203200.78870-8-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> LLD always splits sections with LTO, which increases module sizes. This
> change adds a linker script that merges the split sections in the final
> module and discards the .eh_frame section that LLD may generate.

For discarding .eh_frame, Kees is currently fighting with a series
that I would really like to see land that enables warnings on orphan
section placement.  I don't see any new flags to inhibit .eh_frame
generation, or discard it in the linker script, so I'd expect it to be
treated as an orphan section and kept.  Was that missed, or should
that be removed from the commit message?

>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  Makefile               |  2 ++
>  scripts/module-lto.lds | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 scripts/module-lto.lds
>
> diff --git a/Makefile b/Makefile
> index ee66513a5b66..9ffec5fe1737 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -898,6 +898,8 @@ CC_FLAGS_LTO_CLANG += -fvisibility=default
>  # Limit inlining across translation units to reduce binary size
>  LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
>  KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
> +
> +KBUILD_LDS_MODULE += $(srctree)/scripts/module-lto.lds
>  endif
>
>  ifdef CONFIG_LTO
> diff --git a/scripts/module-lto.lds b/scripts/module-lto.lds
> new file mode 100644
> index 000000000000..65884c652bf2
> --- /dev/null
> +++ b/scripts/module-lto.lds
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
> + * -ffunction-sections, which increases the size of the final module.
> + * Merge the split sections in the final binary.
> + */
> +SECTIONS {
> +       __patchable_function_entries : { *(__patchable_function_entries) }
> +
> +       .bss : {
> +               *(.bss .bss.[0-9a-zA-Z_]*)
> +               *(.bss..L* .bss..compoundliteral*)
> +       }
> +
> +       .data : {
> +               *(.data .data.[0-9a-zA-Z_]*)
> +               *(.data..L* .data..compoundliteral*)
> +       }
> +
> +       .rodata : {
> +               *(.rodata .rodata.[0-9a-zA-Z_]*)
> +               *(.rodata..L* .rodata..compoundliteral*)
> +       }
> +
> +       .text : { *(.text .text.[0-9a-zA-Z_]*) }
> +}
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
