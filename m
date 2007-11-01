Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:32783
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753055AbXKAWiZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 18:38:25 -0400
Date: Thu, 01 Nov 2007 15:38:24 -0700 (PDT)
Message-Id: <20071101.153824.91808126.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0711011511450.22508@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0711010601430.27666@schroedinger.engr.sgi.com>
	<20071101.142936.114015234.davem@davemloft.net>
	<Pine.LNX.4.64.0711011511450.22508@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 1 Nov 2007 15:15:39 -0700 (PDT)

> After boot is complete we allow the reduction of the size of the per cpu 
> areas . Lets say we only need 128k per cpu. Then the remaining pages will
> be returned to the page allocator.

You don't know how much you will need.  I exhausted the limit on
sparc64 very late in the boot process when the last few userland
services were starting up.

And if I subsequently bring up 100,000 IP tunnels, it will exhaust the
per-cpu allocation area.

You have to make it fully dynamic, there is no way around it.
