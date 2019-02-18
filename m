Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33208 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbfBRVSH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 16:18:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id x9so10858082qkf.0
        for <linux-arch@vger.kernel.org>; Mon, 18 Feb 2019 13:18:07 -0800 (PST)
MIME-Version: 1.0
References: <201902190215.BuNxMvI2%fengguang.wu@intel.com>
In-Reply-To: <201902190215.BuNxMvI2%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 22:17:49 +0100
Message-ID: <CAK8P3a3fs=pcQBcB+sGFfuK-pQ-a6du-rJ_VQiyv1_FK2LW2oA@mail.gmail.com>
Subject: Re: [asm-generic:master 4/6] lib/iomap.c:198:48: warning: passing
 argument 1 of 'mmio_insb' discards 'const' qualifier from pointer target type
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Hugo Lefeuvre <hle@owl.eu.com>, kbuild-all@01.org, linux-arch <linux-arch@vger.kernel.org>

On Mon, Feb 18, 2019 at 7:20 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> head:   3c4fcc2648569c3fe573849f9254c8c3499ec648
> commit: 6ce9e34a28174293927e0b51acc4d30a130a565a [4/6] iomap: add missing const to ioread*/iowrite addr arg
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6ce9e34a28174293927e0b51acc4d30a130a565a
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=mips
>
> All warnings (new ones prefixed by >>):
>
>    lib/iomap.c: In function 'ioread8_rep':
> >> lib/iomap.c:198:48: warning: passing argument 1 of 'mmio_insb' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      IO_COND(addr, insb(port,dst,count), mmio_insb(addr, dst, count));
>                                                    ^~~~
>    lib/iomap.c:54:3: note: in definition of macro 'IO_COND'
>       is_mmio;     \
>       ^~~~~~~
>    lib/iomap.c:146:44: note: expected 'void *' but argument is of type 'const void *'
>     static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
>                                  ~~~~~~~~~~~~~~^~~~

It seems to be a result of applying the patches in the wrong order, in
particular
'iomap: add missing const to ioread*/iowrite addr arg' before 'lib/iomap: add
missing const to mmio_ins* addr arg'. I've swapped them around now
and uploaded the new branch.

Hugo, could you check
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
that it still makes sense to you?

       Arnd
