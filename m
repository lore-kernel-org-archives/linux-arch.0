Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46803
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1760930AbXEJWf2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 May 2007 18:35:28 -0400
Date: Thu, 10 May 2007 15:35:31 -0700 (PDT)
Message-Id: <20070510.153531.82102171.davem@davemloft.net>
Subject: Re: New slab allocator SLUB
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0705101533140.13801@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0705101516520.13504@schroedinger.engr.sgi.com>
	<20070510.153019.124084029.davem@davemloft.net>
	<Pine.LNX.4.64.0705101533140.13801@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 10 May 2007 15:33:30 -0700 (PDT)

> On Thu, 10 May 2007, David Miller wrote:
> 
> > From: Christoph Lameter <clameter@sgi.com>
> > Date: Thu, 10 May 2007 15:21:52 -0700 (PDT)
> > 
> > > On Thu, 10 May 2007, David Miller wrote:
> > > 
> > > > What SLAB allows you to do is define LARGE_ALLOCS but not necessarily
> > > > set MAX_ORDER large enough for the largest kmalloc SLAB.  SLAB would
> > > > ignore the kmalloc cache creation failures for these largest ones that
> > > > are over MAX_ORDER.
> > > 
> > > Hmmm... How about limiting KMALLOC_SHIFT_HIGH to max order?
> > 
> > That should definitely do the trick too:
> 
> Could you verify that it indeed does the trick?

Sure... give me a few minutes.
