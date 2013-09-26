From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
Date: Thu, 26 Sep 2013 14:04:53 +0200
Message-ID: <524422E5.9080203@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-2-git-send-email-richard@nod.at> <CALkWK0=W38JpZoGVkPYD4qd=+Pt1G7oYPEK_R=c8TAW6W=wxyg@mail.gmail.com> <52440DE0.1030807@nod.at> <CALkWK0nEy90VrWawTpYsLNJcnyRSizgArCa-qnzpuJQkyK6zHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CALkWK0nEy90VrWawTpYsLNJcnyRSizgArCa-qnzpuJQkyK6zHA@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
List-Id: linux-arch.vger.kernel.org

Am 26.09.2013 13:57, schrieb Ramkumar Ramachandra:
> Richard Weinberger wrote:
>>> $ file linux
>>> linux: ELF 32-bit LSB  executable, Intel 80386, version 1 (SYSV),
>>> dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not
>>> stripped
>>> $ ./linux ubd0=busybox-rootfs
>>> [...]
>>> Kernel panic - not syncing: No init found.  Try passing init= option
>>> to kernel. See Linux Documentation/init.txt for guidance.
>>
>> I don't know that rootfs but it looks like there is no init.
> 
> Ofcourse there's an init on the busybox-rootfs, and I'm able to boot
> it with an x86_64 Linux. The reason for panic is incorrect: I think
> (although not sure) a 32-bit rootfs userland will work.

A 32Bit UML kernel can run 32Bit users, a 64Bit UML kernel can only
run 64Bit userland. We have no 32Bit compat layer on x86_64.
Patches are welcome.

>>> [1]    25526 abort (core dumped)  linux ubd0=busybox-rootfs
>>>                                                            %
>>>
>>> Rubbish.
>>
>> UML core dumps at panic() by design.
> 
> On a related note, why does it screw up my terminal? I have to `reset`
> to get a nice working terminal.

I really don't know. That is not by design.

>> Seriously, my plan is to get rid of SUBARCH, that's why I did not push your patches
>> upstream and I've send the rid of SUBARCH patch series.
>> It turned out that other archs depend on SUBARCH too therefore some more thinking is needed.
>> Time passed, merge window closed, $dayjob needed some attention...
> 
> Don't let some grand plan stall reasonable patches that fix immediate problems.
> 
>> That said, your "arch/um: make it work with defconfig and x86_64" patch is also not perfect.
>> "make defconfig ARCH=um SUBARCH=x86" will create x86_64 defconfig, which is wrong and breaks existing
>> setups.
> 
> Wrong.
> 
>   $ make defconfig ARCH=um SUBARCH=i386
>   *** Default configuration is based on 'i386_defconfig'
>   #
>   # configuration written to .config
>   #

I wrote "SUBARCH=x86" *not* SUBARCH=i386.

Again, if SUBARCH=x86 works too I'll happily merge it.
But as of now it breaks existing setups.

Thanks,
//richard
