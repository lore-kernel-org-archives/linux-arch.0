Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268765AbUHLUcn@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:20691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268753AbUHLUb1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 16:31:27 -0400
Date: Thu, 12 Aug 2004 13:30:24 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040812133024.36e5b7ee.davem@redhat.com>
In-Reply-To: <20040812220025.27cb260a.ak@suse.de>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<20040812020825.GA14411@wotan.suse.de>
	<20040811194545.0034428b.davem@redhat.com>
	<20040812110924.0713f5d9.ak@suse.de>
	<20040812125059.298ae914.davem@redhat.com>
	<20040812220025.27cb260a.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 12 Aug 2004 22:00:25 +0200
Andi Kleen <ak@suse.de> wrote:

> Well, the writes are usually faster. While they don't use the 
> cache they use special write combining buffers in the CPU
> that hold the data until it can blast out a full cache. Advantage
> is that it doesn't have to read anything first.

Sure. Sparc64 has this two, in fact is has a full 2K write
cache to absorb all of the cpu's write traffic.

> How effective this is depends on the CPU, in general newer 
> x86s tend to have much larger WC buffers than the previous 
> generation (e.g. Intel just enlarged them again in Prescott) 
> 
> Unlike all other stores on x86 they are also very lazily ordered
> and need explicit memory barriers.

The cache-bypassing 64-byte block stores behave this way
on sparc64.

> This still has the same problem: in the end the data
> is out of cache and when someone else needs it later they eat
> large penalties.

If it was in the cache to begin with, it will stay there.
This is the case the x86_64 bits lose for, they'll kick
the lines out.

If it is out of cache, no L2 cache lines are allocated.  This
is how x86_64 will perform.

I think the "hit" case behavior difference could make a difference.
