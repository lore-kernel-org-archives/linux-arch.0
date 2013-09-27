From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
Date: Fri, 27 Sep 2013 11:26:16 +0200
Message-ID: <52454F38.60902@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-2-git-send-email-richard@nod.at> <CALkWK0=W38JpZoGVkPYD4qd=+Pt1G7oYPEK_R=c8TAW6W=wxyg@mail.gmail.com> <52440DE0.1030807@nod.at> <52454E58.3010305@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <52454E58.3010305@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, Jeff Dike <jdike@addtoit.com>, gxt@mprc.pku.edu.cn, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

Am 27.09.2013 11:22, schrieb Toralf F=C3=B6rster:
> On 09/26/2013 12:35 PM, Richard Weinberger wrote:
>> Am 26.09.2013 12:20, schrieb Ramkumar Ramachandra:
>>> Richard Weinberger wrote:
>>>> This patch is based on: https://lkml.org/lkml/2013/7/4/396
>>>>
>>>> Cc: Ramkumar Ramachandra <artagnon@gmail.com>
>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>> ---
>>>>  arch/um/configs/i386_defconfig   | 954 ++++++++++++++++++++++++++=
+++++++++++++
>>>>  arch/um/configs/x86_64_defconfig | 943 ++++++++++++++++++++++++++=
++++++++++++
>>>>  2 files changed, 1897 insertions(+)
>>>>  create mode 100644 arch/um/configs/i386_defconfig
>>>>  create mode 100644 arch/um/configs/x86_64_defconfig
>>>
>>> First, I'm pissed that the upstream tree doesn't build and run out =
of
>>> the box months after I submitted a fix in July (and it's September
>>> now). Fact that you dropped my sane patches aside and decided to wr=
ite
>>> a much larger series aside, user-mode Linux in upstream is broken.
>>> This means that any user who does:
>>>
>>> $ ARCH=3Dum make defconfig
>>> $ ARCH=3Dum make
>>>
>>> will end up with a *broken* Linux _today_. Unless the user is livin=
g
>>> in the Stone Age with a 32-bit computer, this is what she will see
>>> when she attempts to boot up Linux:
>=20
> :-{
>=20
> Grmpf
>=20
> There are a lot of 32 bit user land linux installation (beside my own=
,
> look at the x86 Gentoo world) in the wild - even running on modern 64=
bit
> CPUs. The simple reason is that those installations run fine and the
> performance "boost" of 64bit often isn't worth a new reinstallation.

You *can* of course run 32bit userland on UML. Just create a 32bit UML =
on x86_64.

make defconfig ARCH=3Dum SUBARCH=3Di386
make linux ARCH=3Dum SUBARCH=3Di386

This will work on x86_64 and x86 hosts.

Thanks,
//richard
