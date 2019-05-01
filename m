From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: DISCONTIGMEM is deprecated
Date: Wed, 1 May 2019 23:46:17 +0300
Message-ID: <20190501204616.GB6135@rapoport-lnx>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
 <20190423071354.GB12114@infradead.org>
 <20190424113352.GA6278@rapoport-lnx>
 <20190428081107.GA30901@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190428081107.GA30901@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 28, 2019 at 01:11:07AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 02:33:53PM +0300, Mike Rapoport wrote:
> > On Tue, Apr 23, 2019 at 12:13:54AM -0700, Christoph Hellwig wrote:
> > > On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> > > > 32-bit NUMA systems should be non-existent in practice. The last NUMA
> > > > system I'm aware of that was both NUMA and 32-bit only died somewhere
> > > > between 2004 and 2007. If someone is running a 64-bit capable system in
> > > > 32-bit mode with NUMA, they really are just punishing themselves for fun.
> > > 
> > > Can we mark it as BROKEN to see if someone shouts and then remove it
> > > a year or two down the road?  Or just kill it off now..
> > 
> > How about making SPARSEMEM default for x86-32?
> 
> Sounds good.
> 
> Another question:  I always found the option to even select the memory
> models like a bad tradeoff.  Can we really expect a user to make a sane
> choice?  I'd rather stick to a relativelty optimal choice based on arch
> and maybe a few other parameters (NUMA or not for example) and stick to
> it, reducing the testing matrix.

I've sent patches that remove ARCH_SELECT_MEMORY_MODEL from arm, s390 and
sparc where it anyway has no effect [1].

That leaves arm64, ia64, parisc, powerpc, sh and i386.

I'd say that for i386 selecting between FLAT and SPARSE based on NUMA
sounds reasonable.

I'm not familiar enough with others to say if such enforcement makes any
sense.

Probably powerpc and sh can enable the preferred memory model in
platform/board part of their Kconfig, just like arm.

[1] https://lore.kernel.org/lkml/1556740577-4140-1-git-send-email-rppt@linux.ibm.com

-- 
Sincerely yours,
Mike.
