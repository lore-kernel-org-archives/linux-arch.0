Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfBSMrx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 07:47:53 -0500
Date: Tue, 19 Feb 2019 12:47:48 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 14/18] s390/tlb: convert to generic mmu_gather
Message-ID: <20190219124748.GE8501@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.693323478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103233.693323478@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20190219124748.lJoReSav6AyTnQJbSj9oQdSKoffl8pxJuJlI2fS9pfw@z>

On Tue, Feb 19, 2019 at 11:32:02AM +0100, Peter Zijlstra wrote:
> 
> Cc: heiko.carstens@de.ibm.com
> Cc: npiggin@gmail.com
> Cc: akpm@linux-foundation.org
> Cc: aneesh.kumar@linux.vnet.ibm.com
> Cc: will.deacon@arm.com
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux@armlinux.org.uk
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20180918125151.31744-3-schwidefsky@de.ibm.com
> ---
>  arch/s390/Kconfig           |    2 
>  arch/s390/include/asm/tlb.h |  128 +++++++++++++-------------------------------
>  arch/s390/mm/pgalloc.c      |   63 ---------------------
>  3 files changed, 42 insertions(+), 151 deletions(-)

-ENOCOMMITMESSAGE ?

Will
