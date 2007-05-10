Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38775
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755829AbXEJWaQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 May 2007 18:30:16 -0400
Date: Thu, 10 May 2007 15:30:19 -0700 (PDT)
Message-Id: <20070510.153019.124084029.davem@davemloft.net>
Subject: Re: New slab allocator SLUB
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0705101516520.13504@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
	<20070510.151353.89387383.davem@davemloft.net>
	<Pine.LNX.4.64.0705101516520.13504@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 10 May 2007 15:21:52 -0700 (PDT)

> On Thu, 10 May 2007, David Miller wrote:
> 
> > What SLAB allows you to do is define LARGE_ALLOCS but not necessarily
> > set MAX_ORDER large enough for the largest kmalloc SLAB.  SLAB would
> > ignore the kmalloc cache creation failures for these largest ones that
> > are over MAX_ORDER.
> 
> Hmmm... How about limiting KMALLOC_SHIFT_HIGH to max order?

That should definitely do the trick too:

Signed-off-by: David S. Miller <davem@davemloft.net>

I just confirmed that I don't actually need LARGE_ALLOCS on sparc64.
I think I needed them for some reason back when I used kmalloc() to
allocate the per-address-space TLB miss hash tables.

I think the issue was that for Niagara and later really huge TLB
hash table sizes are allowed, and I wanted to experiment with those
and the sizes were large enough to require LARGE_ALLOCS.  But now
I use SLAB for this and I cap the size at the pre-Niagara limit
of 1MB because larger sizes showed no performance gains.

