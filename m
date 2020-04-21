From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>
Date: Wed, 22 Apr 2020 01:12:04 +0900
Message-ID: <CAK7LNASKocVHOSSiEJ4BH+YQcoEt1-p8yXdRwsesGUoQwU8+OQ@mail.gmail.com>
References: <20200419222804.483191-1-masahiroy@kernel.org> <202004212303.QGojecQx%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42832 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUQM5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 12:12:57 -0400
In-Reply-To: <202004212303.QGojecQx%lkp@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Jessica Yu <jeyu@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Leon Romanovsky <leonro@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org

On Wed, Apr 22, 2020 at 12:56 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.7-rc2 next-20200421]
> [cannot apply to arm/for-next arm64/for-next/core ia64/next powerpc/next jeyu/modules-next arc/for-next tip/x86/core]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/arch-split-MODULE_ARCH_VERMAGIC-definitions-out-to-asm-vermagic-h/20200421-194238
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ae83d0b416db002fe95601e7f97f64b59514d936
> config: nios2-3c120_defconfig (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=nios2
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/vermagic.h:6,
>                     from net/ethtool/ioctl.c:20:
> >> ./arch/nios2/include/generated/asm/vermagic.h:1:10: fatal error: asm-generic/vermagic.h: No such file or directory
>        1 | #include <asm-generic/vermagic.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>


Thanks.
include/asm-generic/vermagic.h is a new file.

I forgot to do "git add include/asm-generic/vermagic.h"



-- 
Best Regards
Masahiro Yamada
