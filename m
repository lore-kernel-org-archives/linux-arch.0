From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve
 lpage NUMA support
Date: Wed, 01 Jul 2009 09:48:15 +0900
Message-ID: <4A4AB24F.6050707@kernel.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org> <20090630213146.GA17492@elte.hu> <alpine.DEB.1.10.0906301809330.11362@gentwo.org> <20090630223138.GH1241@elte.hu> <20090630224018.GJ6760@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43818 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192AbZGAAtD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 20:49:03 -0400
In-Reply-To: <20090630224018.GJ6760@one.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <cl@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de

Hello, Andi.

Andi Kleen wrote:
>> How would you allow that guest to stay on 2 virtual CPUs but still 
>> be able to hot-plug many other CPUs if the guest context rises above 
>> its original CPU utilization?
> 
> (unless you're planning to rewrite lots of possible cpu users all over
> the tree) -- the only way is to keep the percpu area small and preallocate. 
> 
> As long as the per cpu data size stays reasonable (not more than a 100-200k)
> that's very doable. It probably won't work with 4096 guest CPUs without
> wasting too much memory, but then I don't think we have any Hypervisor
> that scales to that many CPUs anyways, so it's not the biggest
> concern. For the 128CPU case it works (although i might need
> to enlarge vmalloc area a bit on 32bit) 

I don't see much reason why we should put artificial limit on how much
percpu memory could be used.  For lockdep, that much of percpu memory
is actually necessary.  Another layer of indirection surely can lessen
the pressure on the generic percpu implementation but the problem can
be solved by the generic code without too much difficulty.

Thanks.

-- 
tejun
