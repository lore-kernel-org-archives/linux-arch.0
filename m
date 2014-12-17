From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k, mips)
Date: Wed, 17 Dec 2014 22:30:16 +0000
Message-ID: <yw1xk31phptz.fsf@unicorn.mansr.com>
References: <1418849927.28384.1.camel@perches.com>
	<CAJiQ=7DE1ojVRW6LqZg2LiqTQ0cgDY_a0nMGn=_Rs1mkuEgwoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJiQ=7DE1ojVRW6LqZg2LiqTQ0cgDY_a0nMGn=_Rs1mkuEgwoA@mail.gmail.com>
	(Kevin Cernekee's message of "Wed, 17 Dec 2014 13:30:02 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Joe Perches <joe@perches.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

Kevin Cernekee <cernekee@gmail.com> writes:

> On Wed, Dec 17, 2014 at 12:58 PM, Joe Perches <joe@perches.com> wrote=
:
>> It seems like early_printk can be configured into
>> a few architectures but also appear not to be used.
>>
>> $ git grep -w "early_printk"
> [snip]
>> arch/mips/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)    +=3D early_p=
rintk.o
>
> Nowadays I try to use OF_EARLYCON whenever possible, but when that ha=
s
> been unavailable, I have used arch/mips/kernel/early_printk.c to get
> console output before the serial driver is initialized.  It runs very
> early in the boot sequence and has very few dependencies, which makes
> it useful for board bringup.

EARLY_PRINTK on MIPS is enabled just after prom_init(), well before
OF_EARLYCON is usable.  I'd prefer if it stayed that way.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
