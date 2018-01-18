From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 29/36] nds32: Build infrastructure
Date: Thu, 18 Jan 2018 12:00:28 +0100
Message-ID: <CAK8P3a2k18Z5pK-04h4bSVn82m+tvNL4JdtgVT9AJWP5gKXuig@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e4b231f440511aa0a539ba45f316a096741f530e.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e4b231f440511aa0a539ba45f316a096741f530e.1515766253.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch adds Makefile, Kconfig and vmlinux.lds.S files required for building
> an nds32 kernel.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

I find some new details every time I look here ;-)

> @@ -0,0 +1,107 @@
> +#
> +# For a description of the syntax of this configuration file,
> +# see Documentation/kbuild/kconfig-language.txt.
> +#
> +
> +config NDS32
> +        def_bool y
> +       select ARCH_HAS_RAW_COPY_USER

I don't think this symbol was ever merged. Do you remember why you added it?

> +       select ARCH_WANT_FRAME_POINTERS if FTRACE
> +       select ARCH_WANT_IPC_PARSE_VERSION

You most certainly don't want IPC_PARSE_VERSION, please drop this
and adapt your glibc.

> +       select CLKSRC_MMIO
> +       select CLONE_BACKWARDS
> +       select COMMON_CLK
> +       select FRAME_POINTER

Do you need both ARCH_WANT_FRAME_POINTERS and FRAME_POINTER here?

> +       select GENERIC_ATOMIC64
> +       select GENERIC_CPU_DEVICES
> +       select GENERIC_CLOCKEVENTS
> +       select GENERIC_IRQ_CHIP
> +       select GENERIC_IRQ_PROBE

I think it's better to drop GENERIC_IRQ_PROBE here, no modern driver
should rely on that.

> +choice
> +       prompt "CPU type"
> +       default CPU_V3
> +config CPU_N15
> +       bool "AndesCore N15"
> +config CPU_N13
> +       bool "AndesCore N13"
> +       select CPU_CACHE_ALIASING if ANDES_PAGE_SIZE_4KB
> +config CPU_N10
> +       bool "AndesCore N10"
> +       select CPU_CACHE_ALIASING
> +config CPU_D15
> +       bool "AndesCore D15"
> +config CPU_D10
> +       bool "AndesCore D10"
> +       select CPU_CACHE_ALIASING
> +config CPU_V3
> +       bool "AndesCore v3 compatible"
> +       select ANDES_PAGE_SIZE_8KB
> +endchoice

I forget what we discussed here earlier, but at the very least, there should be
some help text here to explain what the implications are. I assume that you
generally want to be able to build one kernel to run on all of the above, right?

Will selecting 'CPU_V3' result in a kernel binary that can run on all of them?
If so, please explain it here as that is not obvious.

For the other CPU types, can you list the what backwards-compatiblity
you get? E.g. will a kernel built for N13 run on any of N15, D15 or N10?

I think the 'select ANDES_PAGE_SIZE_8KB' cannot work as expected,
since ANDES_PAGE_SIZE_8KB is inside of a 'choice' statement. Since
there are only two options (4K and 8K), you can address that by making
it a simple bool option and fall back to 4K when ANDES_PAGE_SIZE_8KB
is disabled.

> +config CACHE_L2
> +       bool "Support L2 cache"
> +        default y
> +       help
> +         Say Y here to enable L2 cache if your SoC are integrated with L2CC.
> +         If unsure, say N.
> +
> +menu "Memory configuration"
> +
> +choice
> +       prompt "Memory split"
> +       depends on MMU
> +       default VMSPLIT_3G

Why not default to VMSPLIT_3G_OPT?

        Arnd
