From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 19/29] nios2: Time keeping
Date: Mon, 21 Jul 2014 14:35:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407211430300.20847@nanos>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-20-git-send-email-lftan@altera.com> <alpine.DEB.2.10.1407151152310.24854@nanos> <CAFiDJ5_AQ7Rby5Ta=mhzwQ28hiR_VbxbxXemSHqP9OyJmJx+Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59076 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbaGUMfT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jul 2014 08:35:19 -0400
In-Reply-To: <CAFiDJ5_AQ7Rby5Ta=mhzwQ28hiR_VbxbxXemSHqP9OyJmJx+Kw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>

On Mon, 21 Jul 2014, Ley Foon Tan wrote:
> On Tue, Jul 15, 2014 at 6:00 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> >> +     count =
> >> +             readw(timer_membase + ALTERA_TIMER_SNAPH_REG) << 16 |
> >> +             readw(timer_membase + ALTERA_TIMER_SNAPL_REG);
> >
> > So you're serious about having a new architecture with a timer
> > implementation which cant read 32bit in one go? I'm impressed ...
> This is to compatible with 16-bit and 32-bit processors. The older
> version of Nios is 16-bit and Nios II is 32-bit.
> But this timer core doesn't get updated after Nios is end of life.

Sigh.
 
> >> +static cycle_t nios2_timer_read(struct clocksource *cs)
> >> +{
> >> +     unsigned long flags;
> >> +     u32 cycles;
> >> +     u32 tcn;
> >> +
> >> +     local_irq_save(flags);
> >> +     tcn = NIOS2_TIMER_PERIOD - 1 - read_timersnapshot();
> >> +     cycles = nios2_timer_count;
> >
> > This is wrong and completely pointless. The core code takes care about
> > the offset.
> This offset is different from the core code. The core code is handling
> cycle counter overlapping.
> But this is for the offset between last timer interrupt counter and
> current counter (read_timersnapshot()).

So IOW, if you ever lose a timer interrupt, your timekeeping is off by
a full cycle.

Great hardware design, really.

Thanks,

	tglx
