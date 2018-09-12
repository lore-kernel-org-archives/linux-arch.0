Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62451 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILR6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Sep 2018 13:58:39 -0400
MIME-Version: 1.0
In-Reply-To: <0854f35e92c95e552721dc6a46f4ee2bc4020bc1.camel@synopsys.com>
References: <0854f35e92c95e552721dc6a46f4ee2bc4020bc1.camel@synopsys.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Sep 2018 21:53:19 +0900
Message-ID: <CAK7LNAR0ghuhDXUqJ=nX0dtbtoOvFff9Eeu-hHWLkTONG09GAQ@mail.gmail.com>
Subject: Re: defconfig fails if CROSS_COMPILE is set while cross-gcc is not avaialble
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180912125319.R4PsC2wHya5_vc4hZ1hbt3Hf-2IqbXD5j80O2-663t0@z>

Hi Alexey.

2018-09-12 21:08 GMT+09:00 Alexey Brodkin <Alexey.Brodkin@synopsys.com>:
> Hello Masahiro-san,
>
> Starting from kernel v4.17 it is no longer possible to install kernel headers
> for ARC architecture if there's no cross-toolchain in PATH.


Really?

I can do 'make ARCH=arc headers_install'
with the latest Linus' tree.

I see the following warnings, but possible to install kernel headers.

./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found


If ARC compiler is not found in PATH,
those warnings are displayed with v4.16 or older as well.

I do not see much difference in the behavior.


I am trying to fix even those warnings
by eliminating unneeded compiler invocation.  It is WIP.



> Note installation of headers is just one of use-cases when we might not
> have cross-tools available but still want to run "make xxx_defconfig".
> I.e. the problem is "make xxx_defconfig" with no cross-toolchain.
>
> That's what I see:
> ----------------------------->8--------------------------
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> make: arc-linux-gcc: Command not found
> /bin/sh: arc-linux-gcc: command not found
> /bin/sh: arc-linux-gcc: command not found
> *** Default configuration is based on 'nsim_700_defconfig'
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 29: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 29: arc-linux-gcc: command not found
> init/Kconfig:17: syntax error
> init/Kconfig:16: invalid option
> ./scripts/clang-version.sh: line 15: arc-linux-gcc: command not found
> ./scripts/gcc-plugin.sh: line 11: arc-linux-gcc: command not found
> make[1]: *** [scripts/kconfig/Makefile:91: defconfig] Error 1
> make: *** [Makefile:531: defconfig] Error 2
> ----------------------------->8--------------------------
>
> That doesn't happen for ARM and other arches simply because for ARC
> we define CROSS_COMPILE if it is not set by user, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arc/Makefile#n9

I do not think it is a good practice
to forcibly set CROSS_COMPILE that users may not have.

arch/m68k/Makefile uses cc-cross-prefix helper
to set the first found compiler.


> Still if CROSS_COMPILE is set before execution of "make defconfig"
> then the same problem happens for others.
>
> I was able to find a series of commits which cause this problem,
> here they are:
> ----------------------------->8--------------------------
> 59f53855babf - gcc-plugins: test plugin support in Kconfig and clean up Makefile
> 469cb7376c06 - kconfig: add CC_IS_CLANG and CLANG_VERSION
> a4353898980c - kconfig: add CC_IS_GCC and GCC_VERSION
> ----------------------------->8--------------------------
>
> What happen is "$(CC)" is passed as an argument and in its turn CC is
> "$(CROSS_COMPILE)gcc", see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n385
>
>
> So if I substitute "CC" with "HOSTCC" in a couple of places (see below)
> the problem goes away. But I'm not really sure if what I do is correct.
> I.e. when we're interested in CC for target and when only host CC is of
> our interest.

I think the log of commit 316d55d55f49eca44
is a good source to know the background of this change.

Now Kconfig requires the target compiler.
So, it does not make sense to
do defconfig with non-existing compiler.



> Would be interesting to know your opinion here.

I'd recommend to not hard-code CROSS_COMPILE.



Thanks.

-- 
Best Regards
Masahiro Yamada
