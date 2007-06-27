Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dike.telenet-ops.be ([195.130.132.36]:48896 "EHLO
	dike.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbXF0Tfn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jun 2007 15:35:43 -0400
Received: from europa.telenet-ops.be (europa.telenet-ops.be [195.130.137.75])
	by dike.telenet-ops.be (Postfix) with ESMTP id 5BF0A300845
	for <linux-arch@vger.kernel.org>; Wed, 27 Jun 2007 14:24:20 +0200 (CEST)
Date: Wed, 27 Jun 2007 14:23:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
 PowerPC and ARM
In-Reply-To: <1182771454.12109.71.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0706271422250.14839@anakin>
References: <1182761357.12109.14.camel@pmac.infradead.org>
 <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org>
 <20070625110907.GA23438@flint.arm.linux.org.uk> <1182771454.12109.71.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Mon, 25 Jun 2007, David Woodhouse wrote:
> On Mon, 2007-06-25 at 12:09 +0100, Russell King wrote:
> > On Mon, Jun 25, 2007 at 04:35:35AM -0600, Matthew Wilcox wrote:
> > > On Mon, Jun 25, 2007 at 02:11:45AM -0700, Andrew Morton wrote:
> > > > ABI.  How would you like "it would be nice if maintainers of oddball
> > > > architectures would pay attention"?
> > > 
> > > If new syscalls got posted to linux-arch for discussion, I assure you,
> > > we'd pay attention.
> > 
> > Ditto.  sys_sync_file_range() wasn't, so I think David's sentiment is
> > bang on.
> > 
> > And as David says, we've _finally_ been round the discussion loop with
> > fallocate, so in theory we now know what the issues are, and we _all_
> > have a good idea how to deal with argument ordering to satisfy the
> > majority.  That should mean that subsequent discussion be shorter.
> 
> Well, those who were paying attention might. We should probably add
> Documentation/new-syscalls.txt with such information as...
> 
> --- 
> 
> Never add any system call without considering how its prototype works
> for all architectures and for 32-bit userspace on 64-bit kernels.
> 
> - Some architectures have a limit of 6 (32-bit) argument slots.
> - Some architectures must align 64-bit integers into an aligned
>   pair of registers. A slot may be wasted for padding.
> - S390 may not have a 64-bit integer in slots 5/6.
> 
> Where you invent a data structure for communication with userspace, be
> aware of the following:
> 
> - Try to ensure your data structure will be identical for 32-bit and
>   64-bit builds, if possible. That way, you avoid the need to implement
>   compatibility routines for 32-bit userspace on 64-bit kernels. In
>   particular, avoid the 'long' data type. Try to use explicitly sized
>   types such as 'uint64_t' instead.
> - Most architectures align 64-bit integers to 8 bytes, but i386 doesn't.
>   If you have to implement 32-bit compatibility, make sure you get this
>   right. Preferably, avoid the problem by ensuring that your 64-bit 
>   integers are naturally placed with 8-byte alignment even without
>   padding.

Add: patches adding syscalls should be CCed to linux-arch (or does this
expose our precious email address to spammers?)

> > At least now, if they don't, provided we build every -rc kernel as it's
> > released, we can detect when new syscalls are added quickly and give
> > those submitters a suitable roasting at gas mark 95.
> 
> Linus should be refusing any new system call which doesn't at _least_
> handle the 32/64 compatibility issues. Explictly stating that it doesn't
> need compatibility wrappers would be OK, as long as it's true -- but
> just saying _nothing_ about it is bad.

And can we let checkpatch emit a warning for newly added syscalls?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
