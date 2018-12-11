Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbeLKFnS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Dec 2018 00:43:18 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBB5cvRZ130363
        for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2018 00:43:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pa410f0kb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2018 00:43:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 11 Dec 2018 05:43:15 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 13/18] asm-generic/tlb: Introduce HAVE_MMU_GATHER_NO_GATHER
In-Reply-To: <20180926114801.199256189@infradead.org>
References: <20180926113623.863696043@infradead.org> <20180926114801.199256189@infradead.org>
Date: Tue, 11 Dec 2018 11:13:04 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87zhtcsjo7.fsf@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20181211054304.vGHDbhFLkhlsO76YfQNdfBBTt90MjCLA52cdUJG45aI@z>

Peter Zijlstra <peterz@infradead.org> writes:

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>
> Add the Kconfig option HAVE_MMU_GATHER_NO_GATHER to the generic
> mmu_gather code. If the option is set the mmu_gather will not
> track individual pages for delayed page free anymore. A platform
> that enables the option needs to provide its own implementation
> of the __tlb_remove_page_size function to free pages.

Can we rename this to HAVE_NO_BATCH_MMU_GATHER? 

>
> Cc: npiggin@gmail.com
> Cc: heiko.carstens@de.ibm.com
> Cc: will.deacon@arm.com
> Cc: aneesh.kumar@linux.vnet.ibm.com
> Cc: akpm@linux-foundation.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux@armlinux.org.uk
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20180918125151.31744-2-schwidefsky@de.ibm.com

-aneesh
