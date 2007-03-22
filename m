Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2857 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933865AbXCVKBZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2007 06:01:25 -0400
Date: Thu, 22 Mar 2007 10:01:17 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + move-die-notifier-handling-to-common-code.patch added to -mm tree
Message-ID: <20070322100117.GC29627@flint.arm.linux.org.uk>
References: <200703212211.l2LMB08x005006@shell0.pdx.osdl.net> <20070321221748.GD28239@flint.arm.linux.org.uk> <20070321155953.6352e29f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070321155953.6352e29f.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hch@lst.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Mar 21, 2007 at 03:59:53PM -0700, Andrew Morton wrote:
> On Wed, 21 Mar 2007 22:17:48 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > On Wed, Mar 21, 2007 at 03:11:00PM -0700, akpm@linux-foundation.org wrote:
> > > ------------------------------------------------------
> > > Subject: move die notifier handling to common code
> > > From: Christoph Hellwig <hch@lst.de>
> > > 
> > > This patch moves the die notifier handling to common code.  Previous
> > > various architectures had exactly the same code for it.  Note that the new
> > > code is compiled unconditionally, this should be understood as an appel to
> > > the other architecture maintainer to implement support for it aswell (aka
> > > sprinkling a notify_die or two in the proper place)
> > > 
> > > arm had a notifiy_die that did something totally different, I renamed it to
> > > arm_notify_die as part of the patch and made it static to the file it's
> > > declared and used at.  avr32 used to pass slightly less information through
> > > this interface and I brought it into line with the other architectures.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Cc: <linux-arch@vger.kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > 
> > NAK.  This will, as seems to be the current favourite past time, break
> > ARM.  A simple grep command will show why; I leave it as an exercise for
> > those to run this command to discover the details.
> > 
> > $ grep notify_die arch/arm -r
> 
> There seems to be one missed conversion in
> arch/arm/mm/fault.c:do_DataAbort().  If that's not what you mean then
> perhaps you can give us another hint.

That and the blatent removal of the prototype from asm-arm/system.h
along with the non-static declaration in arch/arm/kernel/traps.c
should've been sufficient clue that it might be used somewhere else.
I note that it became static in hch's patch...

It seems that breaking ARM builds is all the rage; they've broken
three times during this cycle due to peoples dumb untested patches,
and with the restrictions Linus placed on my merging it's painful
to keep resolving these issues one week or so after they happen.

Thankfully, I've caught this one prior to it hitting mainline.

Folk *need* to spend more time testing their work before submitting
it upstream.  Merely building the ARM defconfig would've found this
error.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
