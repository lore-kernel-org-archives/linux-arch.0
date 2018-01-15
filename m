From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] microblaze: fix endian handling
Date: Mon, 15 Jan 2018 11:19:54 +0100
Message-ID: <CAK8P3a1zr_9Oy-neCndUgFd1q0pyT07VKbJe2ezw3x6psfut3A@mail.gmail.com>
References: <20180102114720.3408356-1-arnd@arndb.de> <201801140858.DQC0KW38%fengguang.wu@intel.com>
 <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com> <ed24b2c4-c5d0-057c-49c3-57f50c5946b4@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43646 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeAOKT4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 05:19:56 -0500
In-Reply-To: <ed24b2c4-c5d0-057c-49c3-57f50c5946b4@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Babu Moger <babu.moger@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jan 15, 2018 at 11:14 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 15.1.2018 10:29, Arnd Bergmann wrote:
>> On Sun, Jan 14, 2018 at 2:01 AM, kbuild test robot <lkp@intel.com> wrote:
>>> Hi Arnd,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on linus/master]
>>> [also build test ERROR on v4.15-rc7 next-20180112]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/microblaze-fix-endian-handling/20180105-120705
>>> config: microblaze-mmu_defconfig (attached as .config)
>>> compiler: microblaze-linux-gcc (GCC) 7.2.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         make.cross ARCH=microblaze
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> arch/microblaze/lib/fastcopy.S:33:2: error: #error Microblaze LE not support ASM optimized lib func. Disable OPT_LIB_ASM.
>>>     #error Microblaze LE not support ASM optimized lib func. Disable OPT_LIB_ASM.
>>>      ^~~~~
>>>
>>> vim +33 arch/microblaze/lib/fastcopy.S
>>>
>>
>> This seems to be a result of fixing one bug so we run into one that we didn't
>> get to earlier. I still assume my patch is correct.
>
> I will look at this later this week. Xilinx toolchain which I use
> normally are microblaze for BE or microblazeel that's why proper flags
> are default options already that's why I didn't see any issue.
>
> Did you take toolchain from kernel.org?
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/

I used a gcc-7.2.1 that I built myself for all architectures in order to debug
a gcc issue that appeared in gcc-7.2.

The patch that got tested was my workaround for an obviously broken
allmodconfig build.

         Arnd
