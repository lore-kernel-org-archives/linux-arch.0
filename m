Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43568 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbfB1Lkr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Feb 2019 06:40:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so23004841qtc.10
        for <linux-arch@vger.kernel.org>; Thu, 28 Feb 2019 03:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 28 Feb 2019 12:40:25 +0100
Message-ID: <CAK8P3a1Q1uMFLs6eq26Rkv8hQdu0FkPUoq0gDnZPju-Eu1oHgQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] Unify vDSOs across more architectures
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190228114025.a6mLXTnCWK9NEVIrgMNWz_IhK8BwYI-MkTWIzRwqNEs@z>

On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
> This is possible because certain syscalls like gettimeofday() do
> not write any data and return one or more values that are stored
> in the kernel, which makes relatively safe calling them directly
> as a library function.

I tried applying the series on top of v5.0-rc7, and got a set of
build warnings with arm64 defconfig:

In file included from /git/arm-soc/arch/arm64/include/asm/thread_info.h:30:0,
                 from /git/arm-soc/include/linux/thread_info.h:38,
                 from /git/arm-soc/arch/arm64/include/asm/preempt.h:5,
                 from /git/arm-soc/include/linux/preempt.h:78,
                 from /git/arm-soc/include/linux/spinlock.h:51,
                 from /git/arm-soc/include/linux/seqlock.h:36,
                 from /git/arm-soc/include/linux/time.h:6,
                 from /git/arm-soc/lib/vdso/gettimeofday.c:7,
                 from <command-line>:0:
/git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘kaslr_offset’:
/git/arm-soc/arch/arm64/include/asm/memory.h:191:2: warning: left
shift count >= width of type [enabled by default]
  return kimage_vaddr - KIMAGE_VADDR;
  ^
/git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘virt_to_phys’:
/git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
shift count >= width of type [enabled by default]
  return __virt_to_phys((unsigned long)(x));
  ^
/git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
shift count >= width of type [enabled by default]
/git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘phys_to_virt’:
/git/arm-soc/arch/arm64/include/asm/memory.h:289:2: warning: left
shift count >= width of type [enabled by default]
  return (void *)(__phys_to_virt(x));
  ^
In file included from /git/arm-soc/arch/arm64/include/asm/pgtable-hwdef.h:19:0,
                 from /git/arm-soc/arch/arm64/include/asm/processor.h:46,
                 from /git/arm-soc/arch/arm64/include/asm/elf.h:129,
                 from /git/arm-soc/include/linux/elf.h:5,
                 from /git/arm-soc/include/linux/elfnote.h:62,
                 from /git/arm-soc/arch/arm64/kernel/vdso32/note.c:11:
/git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘kaslr_offset’:
/git/arm-soc/arch/arm64/include/asm/memory.h:191:2: warning: left
shift count >= width of type [enabled by default]
  return kimage_vaddr - KIMAGE_VADDR;
  ^
/git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘virt_to_phys’:
/git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
shift count >= width of type [enabled by default]
  return __virt_to_phys((unsigned long)(x));
  ^
/git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
shift count >= width of type [enabled by default]
/git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘phys_to_virt’:
/git/arm-soc/arch/arm64/include/asm/memory.h:289:2: warning: left
shift count >= width of type [enabled by default]
  return (void *)(__phys_to_virt(x));
  ^

I think this is all harmless, but we need to limit the set of header files
that can be included indirectly when compiling the vdso in arm32 mode.

       Arnd
