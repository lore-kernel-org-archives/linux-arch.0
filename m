Return-Path: <BATV+6e876697d14fde6a77e3+5726+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 28 Apr 2019 01:11:07 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190428081107.GA30901@infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
 <20190423071354.GB12114@infradead.org>
 <20190424113352.GA6278@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424113352.GA6278@rapoport-lnx>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Mel Gorman <mgorman@techsingularity.net>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190428081107.NE-rsheyOeCLMk2h93yCBFX-caZO9wTW5OgbCT3tQwU@z>

On Wed, Apr 24, 2019 at 02:33:53PM +0300, Mike Rapoport wrote:
> On Tue, Apr 23, 2019 at 12:13:54AM -0700, Christoph Hellwig wrote:
> > On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> > > 32-bit NUMA systems should be non-existent in practice. The last NUMA
> > > system I'm aware of that was both NUMA and 32-bit only died somewhere
> > > between 2004 and 2007. If someone is running a 64-bit capable system in
> > > 32-bit mode with NUMA, they really are just punishing themselves for fun.
> > 
> > Can we mark it as BROKEN to see if someone shouts and then remove it
> > a year or two down the road?  Or just kill it off now..
> 
> How about making SPARSEMEM default for x86-32?

Sounds good.

Another question:  I always found the option to even select the memory
models like a bad tradeoff.  Can we really expect a user to make a sane
choice?  I'd rather stick to a relativelty optimal choice based on arch
and maybe a few other parameters (NUMA or not for example) and stick to
it, reducing the testing matrix.
