From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] microblaze: fix endian handling
Date: Mon, 15 Jan 2018 10:29:41 +0100
Message-ID: <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com>
References: <20180102114720.3408356-1-arnd@arndb.de> <201801140858.DQC0KW38%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43457 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbeAOJ3m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 04:29:42 -0500
In-Reply-To: <201801140858.DQC0KW38%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Michal Simek <monstr@monstr.eu>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Babu Moger <babu.moger@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Jan 14, 2018 at 2:01 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.15-rc7 next-20180112]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/microblaze-fix-endian-handling/20180105-120705
> config: microblaze-mmu_defconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=microblaze
>
> All errors (new ones prefixed by >>):
>
>>> arch/microblaze/lib/fastcopy.S:33:2: error: #error Microblaze LE not support ASM optimized lib func. Disable OPT_LIB_ASM.
>     #error Microblaze LE not support ASM optimized lib func. Disable OPT_LIB_ASM.
>      ^~~~~
>
> vim +33 arch/microblaze/lib/fastcopy.S
>

This seems to be a result of fixing one bug so we run into one that we didn't
get to earlier. I still assume my patch is correct.

      Arnd
