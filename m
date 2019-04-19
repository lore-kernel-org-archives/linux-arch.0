Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 19 Apr 2019 07:05:21 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: DISCONTIGMEM is deprecated
Message-ID: <20190419140521.GI7751@bombadil.infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419094335.GJ18914@techsingularity.net>
Sender: owner-linux-mm@kvack.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190419140521.FpfhUm-s26NrcSvgomxlyucmBnx5Wb4R3iZzh-j1sgE@z>

On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> DISCONTIG is essentially deprecated and even parisc plans to move to
> SPARSEMEM so there is no need to be fancy, this patch simply disables
> watermark boosting by default on DISCONTIGMEM.

I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
scenarios.  Grepping the arch/ directories shows:

alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
arc (for supporting more than 1GB of memory)
ia64 (looks complicated ...)
m68k (for multiple chunks of memory)
mips (does support NUMA but also non-NUMA)
parisc (both NUMA and non-NUMA)

I'm not sure that these architecture maintainers even know that DISCONTIGMEM
is deprecated.  Adding linux-arch to the cc.
