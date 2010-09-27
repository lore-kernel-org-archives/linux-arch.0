From: Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC trollpatch 1/1] genirq: Remove the fits all and nothing
 __do_IRQ() code
Date: Mon, 27 Sep 2010 10:36:16 -0700
Message-ID: <AANLkTikVHO9DmyTX==CwViDK1rP0masBwjMakHZ0U=kZ@mail.gmail.com>
References: <20100908152036.643594727@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41728 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab0I0RgS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 13:36:18 -0400
In-Reply-To: <20100908152036.643594727@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-alpha@vger.kernel.org, linux-cris-kernel@axis.com, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-ia64@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Greg Ungerer <gerg@uclinux.org>, Jeff Dike <jdike@addtoit.com>, linux-parisc@vger.kernel.org, Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org

On Wed, Sep 8, 2010 at 11:14 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> =A0The following architectures are still using __do_IRQ():
>
> =A0alpha, cris, ia64, h8300, m32r, m68knommu, parisc, um

Thomas,

I (belatedly) took a look at fixing ia64 ... but I've run into a small =
snag.
The __do_IRQ() routine makes a call to:

 desc->chip->end(irq);

while neither of the "handle_level_irq()" nor "handle_edge_irq()"
functions do this.

On ia64 iosapic_end_level_irq() call iosapic_eoi() for me. Without it
my system hangs during boot (with some driver timeout complaining
about dropped interrupts).

Is the omission of desc->chip->end(irq); deliberate? In which case
I need to find another place to call iosapic_eoi(). Or is it accidental=
?

Thanks

-Tony
