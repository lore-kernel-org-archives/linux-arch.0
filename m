From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
Date: Tue, 3 Jul 2018 18:03:04 +0200
Message-ID: <CAK8P3a0v2Dq7-FhSmo5sKrU6JZ2kyqX2zveL-CN3PqVSQRmckg@mail.gmail.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 1, 2018 at 7:30 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

> +choice
> +       prompt "CPU MODEL"
> +       default CPU_CK610
> +
> +config CPU_CK610
> +       bool "CSKY CPU ck610"
> +       select CPU_NEED_TLBSYNC
> +       select CPU_NEED_SOFTALIGN
> +       select CPU_NO_USER_BKPT
> +
> +config CPU_CK810
> +       bool "CSKY CPU ck810"
> +       select CPU_HAS_HILO
> +       select CPU_NEED_TLBSYNC
> +
> +config CPU_CK807
> +       bool "CSKY CPU ck807"
> +       select CPU_HAS_HILO
> +
> +config CPU_CK860
> +       bool "CSKY CPU ck860"
> +       select CPU_HAS_TLBI
> +       select CPU_HAS_CACHEV2
> +       select CPU_HAS_LDSTEX
> +endchoice

It looks like the CK8xx CPUs are basically compatible, so it would
be nice to have a way to configure a kernel that can run on all
of them, picking a safe default for options that depend on a
particular CPU. E.g. when only CK860 supports SMP, you might
start out by making SMP "depend on !(CPU_CK807 || CPU_CK810)",
as an alternative to implementing a way for an SMP-enabled kernel
to run on non-SMP CPUs (arm has that, but it's probably too complex
for your needs).

Similarly, you can set L1_CACHE_BYTES to the largest possible
size, and make things like CPU_TLB_SIZE dynamically detected.

> +menu "C-SKY Debug Options"
> +config CSKY_DEBUG_INFO
> +       bool "Compile the kernel with debug info, just add -g"
> +       depends on !DEBUG_INFO
> +       help
> +         DEBUG_INFO and COMPILE_TEST is conflict, so we provide
> +         another way to support -g.
> +         Some drivers eg: DW_MMC need COMPILE_TEST for new cpu
> +         arch :(

Just send a patch to change those dependencies, there is no reason
not to apply those. Generally speaking, the kernel should not contain
workarounds for particular (mis-)features of the kernel, when you can
just change those.

> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> new file mode 100644
> index 0000000..5de6519
> --- /dev/null
> +++ b/arch/csky/include/asm/Kbuild
> @@ -0,0 +1,72 @@
> +generic-y += asm-offsets.h
> +generic-y += atomic.h

The asm-generic version of atomic.h is a bit inefficient,
you might want to provide an optimized version for your
architecture.

> +generic-y += auxvec.h

You should not need asm/auxvec.h or uapi/asm/auxvec.h

> +generic-y += bitsperlong.h
> +generic-y += bug.h

providing your own bug.h might be helpful too.
Have a look

> +generic-y += bugs.h
> +generic-y += clkdev.h
> +generic-y += cputime.h

asm-generic/cputime.h no loinger exists

> +generic-y += kvm_para.h

Do you support KVM?

> +generic-y += sizes.h

Deprecated and should not be needed

          Arnd
