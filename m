From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: xfs failure on parisc (and presumably other VI cache systems)
 caused by I/O to vmalloc/vmap areas
Date: Tue, 08 Sep 2009 20:39:12 +0000
Message-ID: <1252442352.13003.132.camel@mulgrave.site>
References: <1252434469.13003.3.camel@mulgrave.site>
	 <20090908190031.GF6538@flint.arm.linux.org.uk>
	 <1252437112.13003.39.camel@mulgrave.site>
	 <20090908201619.GG6538@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20090908201619.GG6538@flint.arm.linux.org.uk>
Sender: linux-parisc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On Tue, 2009-09-08 at 21:16 +0100, Russell King wrote:
> On Tue, Sep 08, 2009 at 07:11:52PM +0000, James Bottomley wrote:
> > On Tue, 2009-09-08 at 20:00 +0100, Russell King wrote:
> > > On Tue, Sep 08, 2009 at 01:27:49PM -0500, James Bottomley wrote:
> > > > This bug was observed on parisc, but I would expect it to affect all
> > > > architectures with virtually indexed caches.
> > > 
> > > I don't think your proposed solution will work for ARM with speculative
> > > prefetching (iow, the latest ARM CPUs.)  If there is a mapping present,
> > > it can be speculatively prefetched from at any time - the CPU designers
> > > have placed no bounds on the amount of speculative prefetching which
> > > may be present in a design.
> > 
> > The architecturally prescribed fix for this on parisc is to purge the
> > TLB entry as well.  Without a TLB entry, the CPU is forbidden from doing
> > speculative reads.  This obviously works only as long as the kernel
> > never touches the page during DMA, of course ...
> > 
> > Isn't this also true for arm?
> 
> There appears to be nothing architected along those lines for ARM.
> From the architectural point of view, any "normal memory" mapping is
> a candidate for speculative accesses provided access is permitted via
> the page permissions.
> 
> In other words, if the CPU is permitted to access a memory page, it
> is a candidate for speculative accesses.

So the parisc architectural feature is simply a statement of fact for VI
cache architectures: if you don't have a TLB entry for a page, you can't
do cache operations for it.  We have a software TLB interrupt and the
CPU can't interrupt for a speculation, so it's restricted to the
existing TLB entries in its cache for speculative move ins.

So now we know what the problem is, if arm can't operate this way,
what's your suggestion for fixing this ... I take it you have a DMA
coherence index like we do that flushes the cache on DMA ops?

James


