Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268475AbUHLJJ0@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:17581 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268474AbUHLJJ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 05:09:26 -0400
Date: Thu, 12 Aug 2004 11:09:24 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: clear_user_highpage()
Message-Id: <20040812110924.0713f5d9.ak@suse.de>
In-Reply-To: <20040811194545.0034428b.davem@redhat.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<20040812020825.GA14411@wotan.suse.de>
	<20040811194545.0034428b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 19:45:45 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Thu, 12 Aug 2004 04:08:25 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > I discovered this the hard way on Opteron too. At some point
> > I was doing clear_page using cache bypassing write combining stores.
> > That was done because it was faster in microbenchmarks that just
> > tested the function. But on actual macro benchmarks it was quite
> > bad because the applications were eating cache misses all the time.
> 
> Do these cache-bypassing stores use the L2 cache on a hit?

No, they invalidate the cache.

-Andi
