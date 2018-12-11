From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 00/18] my generic mmu_gather patches
Date: Tue, 11 Dec 2018 11:20:01 +0530
Message-ID: <87woogsjcm.fsf@linux.ibm.com>
References: <20180926113623.863696043@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926113623.863696043@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> Hi,
>
> Here is my current stash of generic mmu_gather patches that goes on top of Will's
> tlb patches:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tlb/asm-generic
>
> And they include the s390 patches done by Heiko. At the end of this, there is
> not a single arch left with a custom mmu_gather.
>
> I've been slow posting these, because the 0-day bot seems to be having trouble
> and I've not been getting the regular cross-build green light emails that I
> otherwise rely upon.
>
> I hope to have addressed all the feedback from the last time, and I've added a
> bunch of missing Cc's from last time.
>
> Please review with care.

What is the update with this patch series? Looks good to be merged
upstream?

You can also add

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

to the series.

-aneesh
