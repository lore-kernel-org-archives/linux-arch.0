Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:41212 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754733AbXKAWsD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 18:48:03 -0400
Date: Thu, 1 Nov 2007 15:48:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
In-Reply-To: <20071101.153824.91808126.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0711011545370.23379@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0711010601430.27666@schroedinger.engr.sgi.com>
 <20071101.142936.114015234.davem@davemloft.net>
 <Pine.LNX.4.64.0711011511450.22508@schroedinger.engr.sgi.com>
 <20071101.153824.91808126.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

On Thu, 1 Nov 2007, David Miller wrote:

> From: Christoph Lameter <clameter@sgi.com>
> Date: Thu, 1 Nov 2007 15:15:39 -0700 (PDT)
> 
> > After boot is complete we allow the reduction of the size of the per cpu 
> > areas . Lets say we only need 128k per cpu. Then the remaining pages will
> > be returned to the page allocator.
> 
> You don't know how much you will need.  I exhausted the limit on
> sparc64 very late in the boot process when the last few userland
> services were starting up.

Well you would be able to specify how much will remain. If not it will 
just keep the 2M reserve around.

> And if I subsequently bring up 100,000 IP tunnels, it will exhaust the
> per-cpu allocation area.

Each tunnel needs 4 bytes per cpu?

> You have to make it fully dynamic, there is no way around it.

Na. Some reasonable upper limit needs to be set. If we set that to say 
32Megabytes and do the virtual mapping then we can just populate the first 
2M and only allocate the remainder if we need it. Then we need to rely on 
Mel's defrag stuff though defrag memory if we need it.

