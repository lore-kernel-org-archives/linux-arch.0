From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: DISCONTIGMEM is deprecated
Date: Sun, 21 Apr 2019 09:38:59 +0300
Message-ID: <20190421063859.GA19926@rapoport-lnx>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419140521.GI7751@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

i386 NUMA as well
 
> I'm not sure that these architecture maintainers even know that DISCONTIGMEM
> is deprecated.  Adding linux-arch to the cc.
> 

-- 
Sincerely yours,
Mike.
