From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
	flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 19:05:24 +0000
Message-ID: <20091210190524.GC20884@flint.arm.linux.org.uk>
References: <20091210023609.b8c9bd34.isloginov@gmail.com> <1260402471.14369.60.camel@mulgrave.site> <20091210030638.db4cfd8a.isloginov@gmail.com> <1260404395.14369.68.camel@mulgrave.site> <20091210074020.a7c36c32.isloginov@gmail.com> <1260464851.2457.98.camel@mulgrave.site> <20091210174823.GA20884@flint.arm.linux.org.uk> <1260467956.2457.109.camel@mulgrave.site> <20091210180635.GB20884@flint.arm.linux.org.uk> <1260469255.2457.113.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51813 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761211AbZLJTFi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 14:05:38 -0500
Content-Disposition: inline
In-Reply-To: <1260469255.2457.113.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, Dec 10, 2009 at 12:20:55PM -0600, James Bottomley wrote:
> On Thu, 2009-12-10 at 18:06 +0000, Russell King wrote:
> > The above example code comes from non-aliasing VIPT - where for the
> > vast majority of cases, unmapping without flush is fine provided we
> > haven't written data.  However, unmapping with flush is required to
> > ensure coherency with the instruction cache.
> 
> right, but you can check those two cases in the unmap, can't you?

How?  (I'd have thought that would've been plainly obvious since I wrote
in the quoted bit below "_if_ you have such flags".)

> > > So I really think in kunmap(_atomic) we need to check to see if the page
> > > was modified (using the pte flags),
> > 
> > That's fine _if_ you have such flags.  Not everything has - in which
> > case, going down the route you're proposing means that every single
> > kunmap_atomic() ends up having to flush the whole page whether it's
> > actually needed on an architecture "just because" - with no technical
> > reason to actually do so.
> > 
> > We need the two cases separated for hardware which is not PARISC.
> 
> So having such a flag is a requirement of the linux mm code, isn't it?
> 
> I thought what you did on arm was mark the page read only (even if it's
> supposed to be read/write) and then trap on the write request and update
> the dirty bit and set the page to read/write ... don't you do that
> anymore?

We do that for user pages, and only user pages - it's partly maintained
by the generic kernel code, and partly by the page table attribute
translation.  We only make pages _user_ writable if they have the Linux
'write' and Linux 'dirty' bits set.  However, they remain writable from
normal kernel stores - but we use a special instruction to access them
which ensures that the user mode permissions get checked.

Essentially, the protections that the majority of ARM CPUs have available
to them are:

	User		Kernel
0:	No access	Read only
1:	No access	Read/write
2:	Read only	Read/write
3:	Read/write	Read/write

The logic we use for implementing the userspace dirty support switches
the page permissions between case 2 and 3 - which is going to be of no
use for kernel accesses.

Moreover, we don't map kernel RAM using 4K pages - we map it using 1MB
section mappings to save the TLB from being cycled through.  If we were
to apply the same principle there, we'd have to do it on a 1MB by 1MB
basis, or take an additional memory hit with TLB usage.

So, in order to have bits for each page, what you're asking for is:
- avoid using efficient section mappings which only use 1 level of
  page table, map everything using 2 levels of page tables using 4K
  pages.
- add code to handle an additional special "dirty" bit processing for
  kernel pages.

I think that is far too inefficient an option to even contemplate.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
