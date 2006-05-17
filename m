Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:18902 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932187AbWEQMMm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 08:12:42 -0400
Date: Wed, 17 May 2006 14:12:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup.
In-Reply-To: <1147867671.5540.3.camel@localhost>
Message-ID: <Pine.LNX.4.62.0605171408240.30686@pademelon.sonytel.be>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
 <20060515212431.GA25010@moss.sous-sol.org> <1147766908.5289.4.camel@localhost>
 <20060516211216.GE23243@moss.sous-sol.org> <1147853851.6661.2.camel@localhost>
 <Pine.LNX.4.62.0605171314440.30686@pademelon.sonytel.be>
 <1147864946.5540.1.camel@localhost> <Pine.LNX.4.62.0605171323330.30686@pademelon.sonytel.be>
 <1147867671.5540.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 17 May 2006, Martin Schwidefsky wrote:
> On Wed, 2006-05-17 at 13:24 +0200, Geert Uytterhoeven wrote:
> > > > Which driver do you use for /dev/rtc? I couldn't find it at first sight.
> > > 
> > > s390 does not have /dev/rtc.
> > 
> > IC.
> > 
> > If you want it, you can easily have it by adding the appropriate genrtc glue.
> 
> Hmm, so far s390 has lived quite happily without /dev/rtc. What is the
> added benefit to have an emulation of a hardware interface that doesn't
> exists for the architecture ?

hwclock(8) can query the hardware clock?

Originally hwclock used direct I/O accesses, which of course work on PC
hardware only, but on `newer' systems it uses /dev/rtc.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
