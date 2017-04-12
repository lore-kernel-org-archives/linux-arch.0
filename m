From: Adam Wallis <awallis@codeaurora.org>
Subject: Re: [RFC PATCH 0/3] arm64: queued spinlocks and rw-locks
Date: Wed, 12 Apr 2017 13:04:55 -0400
Message-ID: <a4f067df-4c22-5c90-d70a-809903c60296@codeaurora.org>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdDLRE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2017 13:04:59 -0400
In-Reply-To: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jan Glauber <jglauber@cavium.com>, Ingo Molnar <mingo@redhat.com>, jason.low2@hp.com

On 4/10/2017 5:35 PM, Yury Norov wrote:
> The patch of Jan Glauber enables queued spinlocks on arm64. I rebased it on
> latest kernel sources, and added a couple of fixes to headers to apply it 
> smoothly.
> 
> Though, locktourture test shows significant performance degradation in the
> acquisition of rw-lock for read on qemu:
> 
>                           Before           After
> spin_lock-torture:      38957034        37076367         -4.83
> rw_lock-torture W:       5369471        18971957        253.33
> rw_lock-torture R:       6413179         3668160        -42.80
> 

On our 48 core QDF2400 part, I am seeing huge improvements with these patches on
the torture tests. The improvements go up even further when I apply Jason Low's
MCS Spinlock patch: https://lkml.org/lkml/2016/4/20/725

> I'm  not much experienced in locking, and so wonder how it's possible that
> simple switching to generic queued rw-lock causes so significant performance
> degradation, while in theory it should improve it. Even more, on x86 there
> are no such problems probably.
> 
> I also think that patches 1 and 2 are correct and useful, and should be applied
> anyway.
> 
> Any comments appreciated.
> 
> Yury.
> 

I will be happy to tests these patches more thoroughly after you get some
additional comments/feedback.

> Jan Glauber (1):
>   arm64/locking: qspinlocks and qrwlocks support
> 
> Yury Norov (2):
>   kernel/locking: #include <asm/spinlock.h> in qrwlock.c
>   asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h
> 
>  arch/arm64/Kconfig                      |  2 ++
>  arch/arm64/include/asm/qrwlock.h        |  7 +++++++
>  arch/arm64/include/asm/qspinlock.h      | 20 ++++++++++++++++++++
>  arch/arm64/include/asm/spinlock.h       | 12 ++++++++++++
>  arch/arm64/include/asm/spinlock_types.h | 14 +++++++++++---
>  include/asm-generic/qspinlock.h         |  1 +
>  include/asm-generic/qspinlock_types.h   |  8 --------
>  kernel/locking/qrwlock.c                |  1 +
>  8 files changed, 54 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/include/asm/qrwlock.h
>  create mode 100644 arch/arm64/include/asm/qspinlock.h
> 

Thanks

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
