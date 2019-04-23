Return-Path: <BATV+307e856acde472aa9de6+5721+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 23 Apr 2019 00:13:54 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190423071354.GB12114@infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421211604.GN18914@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190423071354.3tqDYJzqY0DCt1Atg6mCpsULYOZXdTiHxMyMQ357q3o@z>

On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> 32-bit NUMA systems should be non-existent in practice. The last NUMA
> system I'm aware of that was both NUMA and 32-bit only died somewhere
> between 2004 and 2007. If someone is running a 64-bit capable system in
> 32-bit mode with NUMA, they really are just punishing themselves for fun.

Can we mark it as BROKEN to see if someone shouts and then remove it
a year or two down the road?  Or just kill it off now..
