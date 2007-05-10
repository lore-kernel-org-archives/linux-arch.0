Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:36004 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759574AbXEJWdb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2007 18:33:31 -0400
Date: Thu, 10 May 2007 15:33:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: New slab allocator SLUB
In-Reply-To: <20070510.153019.124084029.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0705101533140.13801@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
 <20070510.151353.89387383.davem@davemloft.net>
 <Pine.LNX.4.64.0705101516520.13504@schroedinger.engr.sgi.com>
 <20070510.153019.124084029.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 10 May 2007, David Miller wrote:

> From: Christoph Lameter <clameter@sgi.com>
> Date: Thu, 10 May 2007 15:21:52 -0700 (PDT)
> 
> > On Thu, 10 May 2007, David Miller wrote:
> > 
> > > What SLAB allows you to do is define LARGE_ALLOCS but not necessarily
> > > set MAX_ORDER large enough for the largest kmalloc SLAB.  SLAB would
> > > ignore the kmalloc cache creation failures for these largest ones that
> > > are over MAX_ORDER.
> > 
> > Hmmm... How about limiting KMALLOC_SHIFT_HIGH to max order?
> 
> That should definitely do the trick too:

Could you verify that it indeed does the trick?
