From: Joe Perches <joe@perches.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
Date: Thu, 18 Dec 2014 18:08:34 -0800
Message-ID: <1418954914.25129.1.camel@perches.com>
References: <1418849927.28384.1.camel@perches.com>
	 <alpine.DEB.2.11.1412190031530.17382@nanos>
	 <1418951658.28384.20.camel@perches.com>
	 <yw1x388ch0su.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <yw1x388ch0su.fsf@unicorn.mansr.com>
Sender: linux-m68k-owner@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 2014-12-19 at 01:43 +0000, M=E5ns Rullg=E5rd wrote:
> What exactly are you proposing to remove?

Optionally compile out
kernel/printk/printk.c:early_printk()
even if CONFIG_EARLY_PRINTK is enabled.

> I see no unused code related
> to early printk (in any variant) under arch/mips.

I think there could be yet another CONFIG option
to specifically enable the early_printk function
for the arches that use it.

The kernel/printk/early_printk() function seems
used only by arm/microblaze/tile/x86.
