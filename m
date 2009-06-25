From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve lpage NUMA support
Date: Thu, 25 Jun 2009 21:54:08 +0200
Message-ID: <20090625195408.GW6760@one.firstfloor.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <20090625000202.GR6760@one.firstfloor.org> <4A42C131.6040007@zytor.com> <20090625091939.GS6760@one.firstfloor.org> <4A43871F.9030507@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:36291 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbZFYTyI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2009 15:54:08 -0400
Content-Disposition: inline
In-Reply-To: <4A43871F.9030507@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de, cl@linux-foundation.org

On Thu, Jun 25, 2009 at 07:18:07AM -0700, H. Peter Anvin wrote:
> Andi Kleen wrote:
> >>>
> >> *Ahem* virtual machines *ahem*...
> > 
> > And? Even there's not that big typically. 
> > 
> > The traditional problem was just for 128 NR_CPUs kernel were nothing
> > was sized based on machine capacity.
> > 
> > Also on large systems the VMs shouldn't be sized for full capacity.
> > 
> 
> We have already have cases where the "possible" CPUs have eaten up the
> entire vmalloc area on 32 bits.  In real use.  It's a real problem.

That's hard to believe or a serious bug/misconfiguration somewhere. 

Each per CPU data should be <100k (let's say 200k with some slack for modules), 
so to fill vmalloc you would need hundreds of CPUs, which a 32bit
kernel doesn't really support anyways because it doesn't support
enough memory for that many CPUs.

Perhaps you had firmware/hypervisor who passed a gigantic impossible
value here? If yes thy

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
