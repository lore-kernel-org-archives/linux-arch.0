Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268690AbUHLTwJ@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268689AbUHLTwH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 15:52:07 -0400
Date: Thu, 12 Aug 2004 12:50:59 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040812125059.298ae914.davem@redhat.com>
In-Reply-To: <20040812110924.0713f5d9.ak@suse.de>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<20040812020825.GA14411@wotan.suse.de>
	<20040811194545.0034428b.davem@redhat.com>
	<20040812110924.0713f5d9.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 12 Aug 2004 11:09:24 +0200
Andi Kleen <ak@suse.de> wrote:

> On Wed, 11 Aug 2004 19:45:45 -0700
> "David S. Miller" <davem@redhat.com> wrote:
> 
> > Do these cache-bypassing stores use the L2 cache on a hit?
> 
> No, they invalidate the cache.

That explains, at least partly, why they performed so poorly.

Is there any other platform that has the same kind of block
stores sparc64 does (basically use L2 cache if line present,
else bypass L2 cache for the store and do not allocate L2
cache lines for the data)?  I bet ia64 does have something
like this.
