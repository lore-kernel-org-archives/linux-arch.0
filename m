Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:11687 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751279AbWHYIMW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 04:12:22 -0400
Date: Fri, 25 Aug 2006 10:12:13 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
In-Reply-To: <20060825003200.GF3580@holomorphy.com>
Message-ID: <Pine.LNX.4.62.0608251011540.3267@pademelon.sonytel.be>
References: <20060824234445.6B519D52@localhost.localdomain>
 <20060824235806.GD3580@holomorphy.com> <1156464441.12011.151.camel@localhost.localdomain>
 <20060825001459.GE3580@holomorphy.com> <1156465424.12011.159.camel@localhost.localdomain>
 <20060825003200.GF3580@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 24 Aug 2006, William Lee Irwin III wrote:
> On Thu, Aug 24, 2006 at 05:23:44PM -0700, Dave Hansen wrote:
> > Is it the Kconfig names themselves which you don't like?  I guess it is
> > a bit silly to have CONFIG_PAGE_SIZE_X, defined to be number Y, which is
> > then calculated back to being X again.  But, we were really already
> > doing that (in three places):
> 
> An integer define would do. Then again, it occurs to me this might be
> some sort of garbage so one can write "4KB," "8KB," etc. on the menus
> presented to the users.

Please don't ask users about `Kelvin bytes' :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
