Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:60769 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbaLSKdv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Dec 2014 05:33:51 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k, mips)
References: <1418849927.28384.1.camel@perches.com>
	<alpine.DEB.2.11.1412190031530.17382@nanos>
	<1418951658.28384.20.camel@perches.com>
	<yw1x388ch0su.fsf@unicorn.mansr.com>
	<1418954914.25129.1.camel@perches.com>
Date: Fri, 19 Dec 2014 10:33:42 +0000
In-Reply-To: <1418954914.25129.1.camel@perches.com> (Joe Perches's message of
	"Thu, 18 Dec 2014 18:08:34 -0800")
Message-ID: <yw1xy4q4exo9.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
Message-ID: <20141219103342.I44C0-12cBXriaQLcI_NyaYlD0TInP5hWlpsyWKBgDE@z>

Joe Perches <joe@perches.com> writes:

> On Fri, 2014-12-19 at 01:43 +0000, Måns Rullgård wrote:
>> What exactly are you proposing to remove?
>
> Optionally compile out
> kernel/printk/printk.c:early_printk()
> even if CONFIG_EARLY_PRINTK is enabled.
>
>> I see no unused code related
>> to early printk (in any variant) under arch/mips.
>
> I think there could be yet another CONFIG option
> to specifically enable the early_printk function
> for the arches that use it.

Why bother?  On MIPS it would save 132 bytes of compiled code.

> The kernel/printk/early_printk() function seems
> used only by arm/microblaze/tile/x86.

Rather than introduce more config complexity, you could try to remove
the 7 remaining uses of early_printk().

- arch/arm/mach-socfpga
  Single early_printk("Early printk initialized\n") call serving no
  apparent purpose can probably be safely deleted.  Since there are no
  other early_printk() calls, this information seems rather useless.

- arch/microblaze, arch/tile, arch/x86
  These all do a register_console() for the early console, so regular
  printk() should work.  Moreover, x86 allows multiple early consoles,
  but calling early_printk() will only output to the last one specified.

-- 
Måns Rullgård
mans@mansr.com
