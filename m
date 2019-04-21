Return-Path: <mgorman@techsingularity.net>
Date: Sun, 21 Apr 2019 22:16:04 +0100
From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190421211604.GN18914@techsingularity.net>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190421132606.GJ7751@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190421211604.DJcTzmnm7qx3sWKAKb8VyLS5uSpXqi9x8KdbS_ZImYc@z>

On Sun, Apr 21, 2019 at 06:26:07AM -0700, Matthew Wilcox wrote:
> On Sun, Apr 21, 2019 at 09:38:59AM +0300, Mike Rapoport wrote:
> > On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> > > On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> > > > DISCONTIG is essentially deprecated and even parisc plans to move to
> > > > SPARSEMEM so there is no need to be fancy, this patch simply disables
> > > > watermark boosting by default on DISCONTIGMEM.
> > > 
> > > I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> > > scenarios.  Grepping the arch/ directories shows:
> > > 
> > > alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> > > arc (for supporting more than 1GB of memory)
> > > ia64 (looks complicated ...)
> > > m68k (for multiple chunks of memory)
> > > mips (does support NUMA but also non-NUMA)
> > > parisc (both NUMA and non-NUMA)
> > 
> > i386 NUMA as well
> 
> I clearly over-trimmed.  The original assumption that Mel had was that
> DISCONTIGMEM => NUMA, and that's not true on the above six architectures.
> It is true on i386 ;-)

32-bit NUMA systems should be non-existent in practice. The last NUMA
system I'm aware of that was both NUMA and 32-bit only died somewhere
between 2004 and 2007. If someone is running a 64-bit capable system in
32-bit mode with NUMA, they really are just punishing themselves for fun.

-- 
Mel Gorman
SUSE Labs
