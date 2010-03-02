From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Fix ARM PIC problems with new decompressor code
Date: Tue, 2 Mar 2010 22:53:13 +0000
Message-ID: <20100302225313.GA6974@flint.arm.linux.org.uk>
References: <20100226081926.GA3511@flint.arm.linux.org.uk> <4B87907B.7080008@knaff.lu> <20100228154908.GB11343@flint.arm.linux.org.uk> <20100302144304.928df4c5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55489 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab0CBWxk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2010 17:53:40 -0500
Content-Disposition: inline
In-Reply-To: <20100302144304.928df4c5.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alain Knaff <alain@knaff.lu>, linux-arch@vger.kernel.org

On Tue, Mar 02, 2010 at 02:43:04PM -0800, Andrew Morton wrote:
> On Sun, 28 Feb 2010 15:49:08 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > On Fri, Feb 26, 2010 at 10:12:27AM +0100, Alain Knaff wrote:
> > > Yes, that should be fine. So it would be static in full kernel context
> > > (initrd decompression) but global in preboot. As long as it doesn't clash
> > > with other variables of the same name, but I think that's rather unlikely
> > > in the "small" preboot environment.
> > 
> > Here's a patch to this end.  I decided to change the name of the
> > define to something more sensible.
> > 
> > Are we happy with this?  Shall I queue it for merging?
> 
> I grabbed it, but you can preempt that by merging it if that's more
> convenient.

Thanks.

> >  I'd be nice
> > to get this into -stable as well as some other fixes for this feature.
> > 
> 
> I don't think I've seen any other fixes.

There's one other in my tree on the same subject in the master branch,
but it's ARM specific.

I'll need an additional patch to define this new STATIC_RW_DATA, so it
probably makes sense for me to collect up all three patches.  Main reason
was to let you see it and check that it passes your taste test. ;)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
