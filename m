From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
Date: Fri, 27 Sep 2013 11:22:32 +0200
Message-ID: <52454E58.3010305@gmx.de>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-2-git-send-email-richard@nod.at> <CALkWK0=W38JpZoGVkPYD4qd=+Pt1G7oYPEK_R=c8TAW6W=wxyg@mail.gmail.com> <52440DE0.1030807@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <52440DE0.1030807@nod.at>
Sender: linux-kbuild-owner@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, Jeff Dike <jdike@addtoit.com>, gxt@mprc.pku.edu.cn, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

On 09/26/2013 12:35 PM, Richard Weinberger wrote:
> Am 26.09.2013 12:20, schrieb Ramkumar Ramachandra:
>> Richard Weinberger wrote:
>>> This patch is based on: https://lkml.org/lkml/2013/7/4/396
>>>
>>> Cc: Ramkumar Ramachandra <artagnon@gmail.com>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>  arch/um/configs/i386_defconfig   | 954 +++++++++++++++++++++++++++=
++++++++++++
>>>  arch/um/configs/x86_64_defconfig | 943 +++++++++++++++++++++++++++=
+++++++++++
>>>  2 files changed, 1897 insertions(+)
>>>  create mode 100644 arch/um/configs/i386_defconfig
>>>  create mode 100644 arch/um/configs/x86_64_defconfig
>>
>> First, I'm pissed that the upstream tree doesn't build and run out o=
f
>> the box months after I submitted a fix in July (and it's September
>> now). Fact that you dropped my sane patches aside and decided to wri=
te
>> a much larger series aside, user-mode Linux in upstream is broken.
>> This means that any user who does:
>>
>> $ ARCH=3Dum make defconfig
>> $ ARCH=3Dum make
>>
>> will end up with a *broken* Linux _today_. Unless the user is living
>> in the Stone Age with a 32-bit computer, this is what she will see
>> when she attempts to boot up Linux:

:-{

Grmpf

There are a lot of 32 bit user land linux installation (beside my own,
look at the x86 Gentoo world) in the wild - even running on modern 64bi=
t
CPUs. The simple reason is that those installations run fine and the
performance "boost" of 64bit often isn't worth a new reinstallation.

--
the stone-age-Toralf

>=20
> Not here.
>=20
>> $ file linux
>> linux: ELF 32-bit LSB  executable, Intel 80386, version 1 (SYSV),
>> dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not
>> stripped
>> $ ./linux ubd0=3Dbusybox-rootfs
>> [...]
>> Kernel panic - not syncing: No init found.  Try passing init=3D opti=
on
>> to kernel. See Linux Documentation/init.txt for guidance.
>=20
> I don't know that rootfs but it looks like there is no init.
>=20
>> CPU: 0 PID: 1 Comm: swapper Not tainted 3.12.0-rc2-00083-g4b97280 #1
>> 0b869fbc 08272f87 0b869fdc 0820c5cd 00000001 00000000 00000000 00000=
000
>>        0b869fe8 0820c126 08252593 0b869ff8 08059317 00000000 0000000=
1 00000000
>>        00000000 0b869f94:  [<0805a11c>] show_stack+0x54/0x8c
>> 0b869fb4:  [<0820e3c8>] dump_stack+0x16/0x1b
>> 0b869fc8:  [<0820c5cd>] panic+0x67/0x149
>> 0b869fe0:  [<0820c126>] kernel_init+0xab/0xaf
>> 0b869fec:  [<08059317>] new_thread_handler+0x63/0x7c
>> 0b869ffc:  [<00000000>] 0x0
>>
>>
>> EIP: 0023:[<f7717430>] CPU: 0 Not tainted ESP: 002b:ffc386dc EFLAGS:=
 00000296
>>     Not tainted
>> EAX: 00000000 EBX: 000063ba ECX: 00000013 EDX: 000063ba
>> ESI: 000063b6 EDI: 00000002 EBP: ffc38708 DS: 002b ES: 002b
>> 0b869f44:  [<0806aff4>] show_regs+0xb4/0xbc
>> 0b869f70:  [<0805b23b>] panic_exit+0x20/0x36
>> 0b869f84:  [<0808521b>] notifier_call_chain+0x28/0x4b
>> 0b869fac:  [<0808526c>] atomic_notifier_call_chain+0x15/0x17
>> 0b869fbc:  [<0820c5de>] panic+0x78/0x149
>> 0b869fe0:  [<0820c126>] kernel_init+0xab/0xaf
>> 0b869fec:  [<08059317>] new_thread_handler+0x63/0x7c
>> 0b869ffc:  [<00000000>] 0x0
>>
>> [1]    25526 abort (core dumped)  linux ubd0=3Dbusybox-rootfs
>>                                                            %
>>
>> Rubbish.
>=20
> UML core dumps at panic() by design.
>=20
>> When I rebase my original patches (exactly 2 small independent
>> patches) onto the new upstream, stuff works as usual. If you're not
>> convinced, try the um-build branch from
>> https://github.com/artagnon/linux for yourself.
>=20
>> Are you against accepting good patches and stalling work? What is yo=
ur
>> plan exactly?
>=20
> Sure, my great plan is to destroy Linux. I work for Microsoft. ;-)
>=20
> Seriously, my plan is to get rid of SUBARCH, that's why I did not pus=
h your patches
> upstream and I've send the rid of SUBARCH patch series.
> It turned out that other archs depend on SUBARCH too therefore some m=
ore thinking is needed.
> Time passed, merge window closed, $dayjob needed some attention...
>=20
> That said, your "arch/um: make it work with defconfig and x86_64" pat=
ch is also not perfect.
> "make defconfig ARCH=3Dum SUBARCH=3Dx86" will create x86_64 defconfig=
, which is wrong and breaks existing
> setups.
> Secondly, what stops you from running "make defconfig ARCH=3Dum SUBAR=
CH=3Dx86_64" to run your x86_64 bit
> userspace?
>=20
> Thanks,
> //richard
>=20


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
