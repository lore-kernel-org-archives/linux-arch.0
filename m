Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbeLKFuQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Dec 2018 00:50:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBB5nDiE084783
        for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2018 00:50:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pa22uugsb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2018 00:50:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 11 Dec 2018 05:50:14 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 00/18] my generic mmu_gather patches
In-Reply-To: <20180926113623.863696043@infradead.org>
References: <20180926113623.863696043@infradead.org>
Date: Tue, 11 Dec 2018 11:20:01 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87woogsjcm.fsf@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, fengguang.wu@intel.com
Message-ID: <20181211055001.DRCMlIeEpRFkg7ehoPpPWlbWLK9csf62ArxVWrkGiD4@z>

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
