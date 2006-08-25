Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:45442 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1422673AbWHYPH1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 11:07:27 -0400
Date: Fri, 25 Aug 2006 17:07:16 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
In-Reply-To: <1156517725.12011.167.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0608251706330.3267@pademelon.sonytel.be>
References: <20060824234445.6B519D52@localhost.localdomain>
 <Pine.LNX.4.62.0608251006390.3267@pademelon.sonytel.be>
 <1156517725.12011.167.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 25 Aug 2006, Dave Hansen wrote:
> --- threadalloc/mm/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
> +++ threadalloc-dave/mm/Kconfig	2006-08-25 07:52:48.000000000 -0700

> +# Note that sparc and m68k vary thier page sizes based
                                   ^^^^^
				   their

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
