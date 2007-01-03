Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2588 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbXACPJo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2007 10:09:44 -0500
Date: Wed, 3 Jan 2007 15:09:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20070103150912.GB25434@flint.arm.linux.org.uk>
References: <1167778403.3687.1.camel@mulgrave.il.steeleye.com> <20070102.151906.21595863.davem@davemloft.net> <1167780858.3687.13.camel@mulgrave.il.steeleye.com> <20070102.162058.55482337.davem@davemloft.net> <20070103141655.GA25434@flint.arm.linux.org.uk> <1167836458.2789.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167836458.2789.6.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: David Miller <davem@davemloft.net>, miklos@szeredi.hu, arjan@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jan 03, 2007 at 09:00:58AM -0600, James Bottomley wrote:
> However, I was wondering if there might be a different way around this.
> We can't really walk all the user mappings because of the locks, but
> could we store the user flush hints in the page (or a related
> structure)?  On parisc we don't care about the process id (called space
> in our architecture) because we've turned off the pieces of the cache
> that match on space id.  Thus, all we care about is flushing with the
> physical address and virtual address (and only about 10 bits of this are
> significant for matching).  We go to great lengths to ensure that every
> mapping in user space all has the same 10 bits of virtual address, so if
> we just new what they were we could flush the whole of the user spaces
> for the page without having to walk any VMA lists.  Could arm do this as
> well?

I don't think so.  The organisation of the VIVT caches in terms of
how the set index and tag correspond with virtual addresses are hardly
ever documented.  When they are, they don't appear to lend themselves
to such an approach.  For example,  Xscale has:

 tag:       virtual address b31-10
 set index: b9-5

and there's 32 ways per set.  So there's nothing to be gained from
controlling the virtual address which individual mappings end up at
in this case.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
