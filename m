From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 7/7] ARM: atomics: define our SMP atomics in terms
 of _relaxed operations
Date: Thu, 16 Jul 2015 16:40:03 -0400
Message-ID: <55A816A3.1000502@hp.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com> <1437060758-10381-8-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:44999 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbGPUkH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 16:40:07 -0400
In-Reply-To: <1437060758-10381-8-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On 07/16/2015 11:32 AM, Will Deacon wrote:
> By defining our SMP atomics in terms of relaxed operations, we gain
> a small reduction in code size and have acquire/release/fence variants
> generated automatically by the core code.
>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
> ---
>   arch/arm/include/asm/atomic.h  | 37 ++++++++++++++-------------------
>   arch/arm/include/asm/cmpxchg.h | 47 +++++++-----------------------------------
>   2 files changed, 24 insertions(+), 60 deletions(-)
>
>
>
> -#define xchg(ptr, x) ({							\
> +#define xchg_relaxed(ptr, x) ({						\
>   	(__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr),		\
>   				   sizeof(*(ptr)));			\
>   })
> @@ -117,6 +115,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>   #error "SMP is not supported on this platform"
>   #endif
>
> +#define xchg xchg_relaxed

Is that a typo? I think xchg() needs to be a full memory barrier.

Cheers,
Longman
