Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:54280 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945920AbXDLHm4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Apr 2007 03:42:56 -0400
Received: from assei2bl6.telenet-ops.be (assei2bl6.telenet-ops.be [195.130.133.69])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id 1483B9EDBE
	for <linux-arch@vger.kernel.org>; Thu, 12 Apr 2007 09:42:45 +0200 (CEST)
Date: Thu, 12 Apr 2007 09:42:21 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added
 to -mm tree
In-Reply-To: <20070411112452.6979414c.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0704120941370.30364@anakin>
References: <20070410194834.b688ce55.akpm@linux-foundation.org>
 <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com>
 <1176257950.26372.50.camel@localhost.localdomain> <14926.1176288559@redhat.com>
 <20070411112452.6979414c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Apr 2007, Andrew Morton wrote:
> On Wed, 11 Apr 2007 11:49:19 +0100
> David Howells <dhowells@redhat.com> wrote:
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > > To me, "val_outside" means "true if the value is outside":
> > > 
> > > bool val_outside(val, start, len)
> > > {
> > > 	return val < start || val > (start+len-1);
> > > }
> > > 
> > > that's what my function does.
> > 
> > Seconded.  Again, I would suggest calling it something like limit_check() or
> > range_check().
> 
> I suspect we would benefit from a proper suite of tools for comparing a
> single number against a range, and for comparing ranges.  As you say, it's

And probably we want a generic routine to do intersections of ranges,
too?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
