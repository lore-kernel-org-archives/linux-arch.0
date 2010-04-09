From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/13] mm: preemptibility -v2
Date: Thu, 08 Apr 2010 18:00:01 -0700 (PDT)
Message-ID: <20100408.180001.85226459.davem@davemloft.net>
References: <20100408191737.296180458@chello.nl>
	<20100408.132935.202349434.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54131
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768Ab0DIA76 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 20:59:58 -0400
In-Reply-To: <20100408.132935.202349434.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: a.p.zijlstra@chello.nl
Cc: aarcange@redhat.com, avi@redhat.com, tglx@linutronix.de, riel@redhat.com, mingo@elte.hu, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, benh@kernel.crashing.org, hugh.dickins@tiscali.co.uk, mel@csn.ul.ie, npiggin@suse.de

From: David Miller <davem@davemloft.net>
Date: Thu, 08 Apr 2010 13:29:35 -0700 (PDT)

> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date: Thu, 08 Apr 2010 21:17:37 +0200
> 
>> This patch-set seems to build and boot on my x86_64 machines and even builds a
>> kernel. I've also attempted powerpc and sparc, which I've compile tested with
>> their respective defconfigs, remaining are (afaikt the rest uses the generic
>> tlb bits):
> 
> Did a build and test boot of this on my 128-cpu Niagara2 box, seems to
> work basically fine.

Here comes a set of 4 patches which build on top of your
work by:

1) Killing quicklists on sparc64
2) Using the generic RCU page table liberation code on sparc64
3) Implement pte_special() et al. on sparc64
4) Implement get_user_pages_fast() on sparc64

Please add them to your patch set.  If you change the RCU generic code
enabler CPP define to be controlled via Kconfig (as we discussed on
IRC) it should be easy to propagate that change into patch #2 here.

Thanks!
