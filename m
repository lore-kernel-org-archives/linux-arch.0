From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: xfs failure on parisc (and presumably other VI cache systems)
	caused by I/O to vmalloc/vmap areas
Date: Tue, 8 Sep 2009 21:16:19 +0100
Message-ID: <20090908201619.GG6538@flint.arm.linux.org.uk>
References: <1252434469.13003.3.camel@mulgrave.site> <20090908190031.GF6538@flint.arm.linux.org.uk> <1252437112.13003.39.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1252437112.13003.39.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 08, 2009 at 07:11:52PM +0000, James Bottomley wrote:
> On Tue, 2009-09-08 at 20:00 +0100, Russell King wrote:
> > On Tue, Sep 08, 2009 at 01:27:49PM -0500, James Bottomley wrote:
> > > This bug was observed on parisc, but I would expect it to affect all
> > > architectures with virtually indexed caches.
> > 
> > I don't think your proposed solution will work for ARM with speculative
> > prefetching (iow, the latest ARM CPUs.)  If there is a mapping present,
> > it can be speculatively prefetched from at any time - the CPU designers
> > have placed no bounds on the amount of speculative prefetching which
> > may be present in a design.
> 
> The architecturally prescribed fix for this on parisc is to purge the
> TLB entry as well.  Without a TLB entry, the CPU is forbidden from doing
> speculative reads.  This obviously works only as long as the kernel
> never touches the page during DMA, of course ...
> 
> Isn't this also true for arm?

There appears to be nothing architected along those lines for ARM.
From the architectural point of view, any "normal memory" mapping is
a candidate for speculative accesses provided access is permitted via
the page permissions.

In other words, if the CPU is permitted to access a memory page, it
is a candidate for speculative accesses.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
