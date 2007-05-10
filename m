Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39305
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754359AbXEJXBv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 May 2007 19:01:51 -0400
Date: Thu, 10 May 2007 16:01:53 -0700 (PDT)
Message-Id: <20070510.160153.70707905.davem@davemloft.net>
Subject: Re: New slab allocator SLUB
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0705101543320.13998@schroedinger.engr.sgi.com>
References: <20070510.153531.82102171.davem@davemloft.net>
	<20070510.153843.66277978.davem@davemloft.net>
	<Pine.LNX.4.64.0705101543320.13998@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 10 May 2007 15:44:12 -0700 (PDT)

> On Thu, 10 May 2007, David Miller wrote:
> 
> > Ugh, it won't build, you can't use min() because this is
> > evaluated at compile time to compute array sizes etc.
> > 
> > include/linux/slub_def.h:76: error: braced-group within expression allowed only inside a function
> 
> Rats. Then we have to do it by hand. This compiles here...

Unfortunately, still no dice with LARGE_ALLOCS=y/SLUB=y on sparc64.
It still tries to create the 16MB kmalloc cache even though MAX_ORDER
is 11. :-)

I think this is an off-by-one error, the kmalloc cache builder
iterates to >= KMALLOC_SHIFT_HIGH but your min() on MAX_ORDER would
only work if it iterated to > KMALLOC_SHIFT_HIGH.
