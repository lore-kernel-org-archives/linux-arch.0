Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:54266 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877AbXEQMqL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2007 08:46:11 -0400
Received: from europa.telenet-ops.be (europa.telenet-ops.be [195.130.137.75])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id D77129CE99
	for <linux-arch@vger.kernel.org>; Thu, 17 May 2007 14:45:58 +0200 (CEST)
Date: Thu, 17 May 2007 14:45:35 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: sparse (was: Re: [RFC] Explicitly mark global functions with
 vmlinux with __global)
In-Reply-To: <1179395810.2859.462.camel@shinybook.infradead.org>
Message-ID: <Pine.LNX.4.64.0705171435330.20754@anakin>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
 <alpine.LFD.0.98.0705161119110.3890@woody.linux-foundation.org>
 <1179370402.2859.390.camel@shinybook.infradead.org> <Pine.LNX.4.64.0705171147240.20754@anakin>
 <1179395810.2859.462.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 17 May 2007, David Woodhouse wrote:
> On Thu, 2007-05-17 at 11:49 +0200, Geert Uytterhoeven wrote:
> > I guess af_ipx.c didn't include the relevant header file?
> > 
> > This is something sparse can find out now, too (as I found out
> > yesterday): if something is non-static, sparse gives a warning if it
> > hasn't seen a prototype in a header file.
> 
> In the IPX case, af_ipx.c _does_ have a prototype for the offending
> function; it's just that it doesn't actually match the function itself.

But the prototype is in af_ipx.c, not in a header file.

Hence sparse complains for ipx_route.c:

|   CHECK   /usr/people/geert.nba/ps3/ps3-linux-2.6.22-rc1/net/ipx/ipx_route.c
| linux-2.6.22-rc1/net/ipx/ipx_route.c:32:18: warning: symbol 'ipxrtr_lookup' was not declared. Should it be static?
| linux-2.6.22-rc1/net/ipx/ipx_route.c:51:5: warning: symbol 'ipxrtr_add_route' was not declared. Should it be static?
| linux-2.6.22-rc1/net/ipx/ipx_route.c:93:6: warning: symbol 'ipxrtr_del_routes' was not declared. Should it be static?
| linux-2.6.22-rc1/net/ipx/ipx_route.c:148:5: warning: symbol 'ipxrtr_route_skb' was not declared. Should it be static?
| linux-2.6.22-rc1/net/ipx/ipx_route.c:170:5: warning: symbol 'ipxrtr_route_packet' was not declared. Should it be static?
| linux-2.6.22-rc1/net/ipx/ipx_route.c:260:5: warning: symbol 'ipxrtr_ioctl' was not declared. Should it be static?
|   CC      net/ipx/ipx_route.o

Killing these warnings implies putting the prototypes in a header file.
If it's already in a header file, ipx_route.c doesn't include it.
If it's not yet in a header file, this is a sign there may be some prototypes
in source files (i.e. af_ipx.c), which may not match.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
