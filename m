Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 19 Apr 2019 15:28:35 +0100
From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190419142835.GM18914@techsingularity.net>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190419140521.GI7751@bombadil.infradead.org>
Sender: owner-linux-mm@kvack.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190419142835.pNwbVUTtG-wMmrnQHh7JSGpjpJN0UgsyueubIDS5b84@z>

On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> > DISCONTIG is essentially deprecated and even parisc plans to move to
> > SPARSEMEM so there is no need to be fancy, this patch simply disables
> > watermark boosting by default on DISCONTIGMEM.
> 
> I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> scenarios.  Grepping the arch/ directories shows:
> 
> alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> arc (for supporting more than 1GB of memory)
> ia64 (looks complicated ...)
> m68k (for multiple chunks of memory)
> mips (does support NUMA but also non-NUMA)
> parisc (both NUMA and non-NUMA)
> 
> I'm not sure that these architecture maintainers even know that DISCONTIGMEM
> is deprecated.  Adding linux-arch to the cc.

Poor wording then -- yes, DISCONTIGMEM is still used but look where it's
used. I find it impossible to believe that any new arch would support
DISCONTIGMEM or that DISCONTIGMEM would be selected when SPARSEMEM is
available.`It's even more insane when you consider that SPARSEMEM can be
extended to support VMEMMAP so that it has similar overhead to FLATMEM
when mapping pfns to struct pages and vice-versa.

-- 
Mel Gorman
SUSE Labs
