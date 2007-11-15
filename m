Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from agave.telenet-ops.be ([195.130.137.77]:57103 "EHLO
	agave.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765999AbXKOWNQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2007 17:13:16 -0500
Date: Thu, 15 Nov 2007 23:13:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: HAVE or ARCH_HAS or ARCH_SUPPORTS and use of select
In-Reply-To: <20071115181451.GA23914@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0711152312210.8650@anakin>
References: <20071115090215.GA20612@uranus.ravnborg.org> <20071115122151.GA10359@Krystal>
 <20071115181451.GA23914@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>, linux arch <linux-arch@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 15 Nov 2007, Sam Ravnborg wrote:
> On Thu, Nov 15, 2007 at 07:21:51AM -0500, Mathieu Desnoyers wrote:
> > 
> > FWIW, I've used "NEED_*" in my LTTng patchset to specify when an
> > architecture needs support from an architecture independent module. (it
> > could be an alternative to USE_*).
> 
> The situations we need to cover are:

> 2) An architecture uses a specific functionality
>    Examples: MMU

That's always been just CONFIG_MMU.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
