Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268184AbUIGOtJ@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:48277 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268177AbUIGOsk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 10:48:40 -0400
Date: Tue, 7 Sep 2004 16:48:14 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
In-Reply-To: <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0409071644420.518@waterleaf.sonytel.be>
References: <20040831183655.58d784a3.pj@sgi.com> <20040904133701.GE33964@muc.de>
 <20040904171417.67649169.pj@sgi.com> <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
 <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
 <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
 <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com>
 <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
 <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 7 Sep 2004, Linus Torvalds wrote:
> Now, it will _only_ break systems that are _both_ 64-bit _and_ big-endian.
> Little-endian or 32-bit boxes will never care.
>
> There aren't that many of those machines. I've got one right here (ppc64),
> but that particular one is guaranteed not to break if only because it's
> running a 32-bit user space.
>
> So it's ppc64, sparc64, s390x and sh64. I suspect the breakage is
> basically zero, since not only aren't there _that_ many machines out
> there, the percentage of them that use setaffinity or mbind is likely not
> that high either.

And mips64, and parisc...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
