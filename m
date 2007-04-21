Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57945
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752989AbXDUEpb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Apr 2007 00:45:31 -0400
Date: Fri, 20 Apr 2007 21:45:34 -0700 (PDT)
Message-Id: <20070420.214534.35875646.davem@davemloft.net>
Subject: Re: Better local_t implementation needed
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0704201723010.13787@schroedinger.engr.sgi.com>
References: <200704202325.06301.zippel@linux-m68k.org>
	<20070420.153951.91208263.davem@davemloft.net>
	<Pine.LNX.4.64.0704201723010.13787@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: zippel@linux-m68k.org, ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Fri, 20 Apr 2007 17:25:16 -0700 (PDT)

> On Fri, 20 Apr 2007, David Miller wrote:
> 
> > That's correct for hardware interrupts.  It will, however, work for
> > soft interrupts and similar contexts.
> 
> Is there really a significant gain? It seems that such logic would be more 
> expensive than an atomic operation.
> 
> local_t is saving atomic overhead right? It does no good for cacheline 
> contention etc. Adding another int will increase cache footprint. 
> Another rat hole?

We've been doing it for SNMP statistics in the networking for a long
time and I'm pretty sure it's better than an atomic at least on
sparc64 where the atomic is 40 cycles minimum on several processors.

I really don't want to start using local_t's all over the damn place
if they are implemented as atomics until they are proven to be faster
which I doubt they are on sparc64 for one.
