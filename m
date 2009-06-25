From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve lpage NUMA support
Date: Thu, 25 Jun 2009 02:02:02 +0200
Message-ID: <20090625000202.GR6760@one.firstfloor.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34115 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbZFYACE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2009 20:02:04 -0400
Content-Disposition: inline
In-Reply-To: <20090624165508.30b88343.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de, cl@linux-foundation.org

> I assume from the tremendous number of for_each_possible_cpu()s that
> CPU hotplug awareness won't be happening.
> 
> Do we have a feeling for the amount of wastage here?  If
> 
> 	num_possible_cpus() - num_online_cpus() == N

Haven't read the new patches, but per cpu data always was sized
for all possible CPUs.

> and N is large, what did it cost?

> And what are reasonable values of N?

N should normally not be large anymore, since num_possible_cpus() 
is sized based on firmware information now.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
