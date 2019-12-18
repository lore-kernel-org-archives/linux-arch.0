Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfLRJPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2019 04:15:12 -0500
Date: Wed, 18 Dec 2019 10:14:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/3] powerpc/mmu_gather: Enable RCU_TABLE_FREE even
 for !SMP case
Message-ID: <20191218091454.GN2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20191218091454.Esm5kMR1da8Axlt6BLHFDit89qsouwy5NYZh2t_9vKc@z>


I'm going to assume you'll take these 3 patches through the powerpc tree
for convenience, a few small nits, but otherwise ACK on the lot.

On Wed, Dec 18, 2019 at 11:05:28AM +0530, Aneesh Kumar K.V wrote:
> A follow up patch is going to make sure we correctly invalidate page walk cache
> before we free page table pages. In order to keep things simple enable
> RCU_TABLE_FREE even for !SMP so that we don't have to fixup the !SMP case
> differently in the followup patch

Perhaps more clearly state that !SMP is broken for Radix/PWC. The above
sorta implies it is, but it's not spelled out in any detail.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
