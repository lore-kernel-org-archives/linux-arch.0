Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:59763 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbXEQJtp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2007 05:49:45 -0400
Received: from assei2bl6.telenet-ops.be (assei2bl6.telenet-ops.be [195.130.133.69])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id A06C29FF67
	for <linux-arch@vger.kernel.org>; Thu, 17 May 2007 11:49:43 +0200 (CEST)
Date: Thu, 17 May 2007 11:49:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: sparse (was: Re: [RFC] Explicitly mark global functions with vmlinux
 with __global)
In-Reply-To: <1179370402.2859.390.camel@shinybook.infradead.org>
Message-ID: <Pine.LNX.4.64.0705171147240.20754@anakin>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
 <alpine.LFD.0.98.0705161119110.3890@woody.linux-foundation.org>
 <1179370402.2859.390.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 17 May 2007, David Woodhouse wrote:
> -- it found a few bugs with mismatching prototypes, such as the fact
> that ipxrtr_route_packet() actually takes a 'len' argument of type
> 'size_t', but is declared and called in af_ipx.c as if that argument is
> 'int'. (Oops, I thought I'd chased all of combine-diff-1-fixes.patch
> upstream already).

I guess af_ipx.c didn't include the relevant header file?

This is something sparse can find out now, too (as I found out
yesterday): if something is non-static, sparse gives a warning if it hasn't
seen a prototype in a header file.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
