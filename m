Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfHGAIU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Aug 2019 20:08:20 -0400
Date: Wed, 7 Aug 2019 09:08:11 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 0/3] arm/arm64: Add support for function error
 injection
Message-ID: <20190807090811.1e50eb3e1d5a7b85743748e7@kernel.org>
In-Reply-To: <20190806100015.11256-1-leo.yan@linaro.org>
References: <20190806100015.11256-1-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Message-ID: <20190807000811.JVmEmyCtkAtcpP7IAlWDjHkYlvJdY_rMkpjOYA_YsCI@z>

On Tue,  6 Aug 2019 18:00:12 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> This small patch set is to add support for function error injection;
> this can be used to eanble more advanced debugging feature, e.g.
> CONFIG_BPF_KPROBE_OVERRIDE.
> 
> The patch 01/03 is to consolidate the function definition which can be
> suared cross architectures, patches 02,03/03 are used for enabling
> function error injection on arm64 and arm architecture respectively.
> 
> I tested on arm64 platform Juno-r2 and one of my laptop with x86
> architecture with below steps; I don't test for Arm architecture so
> only pass compilation.
> 
> - Enable kernel configuration:
>   CONFIG_BPF_KPROBE_OVERRIDE
>   CONFIG_BTRFS_FS
>   CONFIG_BPF_EVENTS=y
>   CONFIG_KPROBES=y
>   CONFIG_KPROBE_EVENTS=y
>   CONFIG_BPF_KPROBE_OVERRIDE=y
> 
> - Build samples/bpf on with Debian rootFS:
>   # cd $kernel
>   # make headers_install
>   # make samples/bpf/ LLC=llc-7 CLANG=clang-7
> 
> - Run the sample tracex7:
>   # dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
>   # DEVICE=$(losetup --show -f testfile.img)
>   # mkfs.btrfs -f $DEVICE
>   # ./tracex7 testfile.img
>   [ 1975.211781] BTRFS error (device (efault)): open_ctree failed
>   mount: /mnt/linux-kernel/linux-cs-dev/samples/bpf/tmpmnt: mount(2) system call failed: Cannot allocate memory.
> 
> Changes from v1:
> * Consolidated the function definition into asm-generic header (Will);
> * Used APIs to access pt_regs elements (Will);
> * Fixed typos in the comments (Will).

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> 
> Leo Yan (3):
>   error-injection: Consolidate override function definition
>   arm64: Add support for function error injection
>   arm: Add support for function error injection
> 
>  arch/arm/Kconfig                           |  1 +
>  arch/arm/include/asm/ptrace.h              |  5 +++++
>  arch/arm/lib/Makefile                      |  2 ++
>  arch/arm/lib/error-inject.c                | 19 +++++++++++++++++++
>  arch/arm64/Kconfig                         |  1 +
>  arch/arm64/include/asm/ptrace.h            |  5 +++++
>  arch/arm64/lib/Makefile                    |  2 ++
>  arch/arm64/lib/error-inject.c              | 18 ++++++++++++++++++
>  arch/powerpc/include/asm/error-injection.h | 13 -------------
>  arch/x86/include/asm/error-injection.h     | 13 -------------
>  include/asm-generic/error-injection.h      |  6 ++++++
>  include/linux/error-injection.h            |  6 +++---
>  12 files changed, 62 insertions(+), 29 deletions(-)
>  create mode 100644 arch/arm/lib/error-inject.c
>  create mode 100644 arch/arm64/lib/error-inject.c
>  delete mode 100644 arch/powerpc/include/asm/error-injection.h
>  delete mode 100644 arch/x86/include/asm/error-injection.h
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
