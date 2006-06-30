Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:48895 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932201AbWF3NU3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 09:20:29 -0400
Date: Fri, 30 Jun 2006 15:20:21 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
In-Reply-To: <200606301509.16981.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0606301517540.12536@pademelon.sonytel.be>
References: <1151670404.11575.5.camel@localhost> <200606301444.26446.ak@suse.de>
 <1151672682.11575.16.camel@localhost> <200606301509.16981.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 30 Jun 2006, Andi Kleen wrote:
> On Friday 30 June 2006 15:04, Martin Schwidefsky wrote:
> > On Fri, 2006-06-30 at 14:44 +0200, Andi Kleen wrote:
> > > On Friday 30 June 2006 14:26, Martin Schwidefsky wrote:
> > > > Hi folks,
> > > > it has been a few weeks since the s390 kconfig discussion died down.
> > > > I have put together a new patch that includes all of the suggestions
> > > > made so far. With this patch "make allyesconfig" and "make allmodconfig"
> > > > now works on s390.
> > > > 
> > > > Please check that it does not break anything on your favorite 
> > > > architecture. It really shouldn't but you never know. I want to push
> > > > this patch soon.
> > > 
> > > I must say I still hate the negative !S390. It would be much better
> > > to define something positive. If PCI doesn't work maybe something 
> > > else.
> > 
> > Well, I don't like these negative !S390 depends as well. But I can't
> > help it, there is no other existing config symbol that can be used for a
> > positive dependency. Hardware that is built into the machine and is not
> > attached via some kind of bus does not have any dependency. 
> 
> But one can be invented. 
> 
> DESKTOP_HARDWARE
> SMALL_IRON
> END_USER_PCI
> ...
> 
> Chose one.
> 
> What stops users from plugging a PCI sound card into your PCI slots 
> BTW?

Since Martin added several `depends on PCI', it seems like big iron doesn't
have PCI (or perhaps PCI depends on !S390 now? :-).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
