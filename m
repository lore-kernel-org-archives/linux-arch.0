Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268717AbUHLUDA@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35559 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268716AbUHLUDA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 16:03:00 -0400
Date: Thu, 12 Aug 2004 22:00:25 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: clear_user_highpage()
Message-Id: <20040812220025.27cb260a.ak@suse.de>
In-Reply-To: <20040812125059.298ae914.davem@redhat.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<20040812020825.GA14411@wotan.suse.de>
	<20040811194545.0034428b.davem@redhat.com>
	<20040812110924.0713f5d9.ak@suse.de>
	<20040812125059.298ae914.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 12 Aug 2004 12:50:59 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Thu, 12 Aug 2004 11:09:24 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Wed, 11 Aug 2004 19:45:45 -0700
> > "David S. Miller" <davem@redhat.com> wrote:
> > 
> > > Do these cache-bypassing stores use the L2 cache on a hit?
> > 
> > No, they invalidate the cache.
> 
> That explains, at least partly, why they performed so poorly.

Well, the writes are usually faster. While they don't use the 
cache they use special write combining buffers in the CPU
that hold the data until it can blast out a full cache. Advantage
is that it doesn't have to read anything first.

How effective this is depends on the CPU, in general newer 
x86s tend to have much larger WC buffers than the previous 
generation (e.g. Intel just enlarged them again in Prescott) 

Unlike all other stores on x86 they are also very lazily ordered
and need explicit memory barriers.

Normally it is used for frame buffers and other hardware 
mappings, but sometimes it can be useful for a lot of streaming
data too.
 
> Is there any other platform that has the same kind of block
> stores sparc64 does (basically use L2 cache if line present,
> else bypass L2 cache for the store and do not allocate L2
> cache lines for the data)?  I bet ia64 does have something
> like this.

This still has the same problem: in the end the data
is out of cache and when someone else needs it later they eat
large penalties.

-Andi

P.S.: I added a new experimental option now to use unordered WC 
stores for writel(). Haven't benchmarked it much so far though.
