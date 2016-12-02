Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 001b2d01.pphosted.com ([148.163.156.1]:39776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751157AbcLBPnv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2016 10:43:51 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uB2FZcUL099559
        for <linux-arch@vger.kernel.org>; Fri, 2 Dec 2016 10:43:29 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2737vtx83q-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2016 10:43:28 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Fri, 2 Dec 2016 08:43:27 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] proc: mm: export PTE sizes directly in smaps (v3)
In-Reply-To: <20161129201703.CE9D5054@viggo.jf.intel.com>
References: <20161129201703.CE9D5054@viggo.jf.intel.com>
Date: Fri, 02 Dec 2016 21:13:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <877f7ie3qg.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
Cc: hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com, khandual@linux.vnet.ibm.com, vbabka@suse.cz, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20161202154319.yC054LKIqzNczb3SdPlV8YkseL-c62qed0WaXnhAxKk@z>

Dave Hansen <dave@sr71.net> writes:

> Andrew, you can drop proc-mm-export-pte-sizes-directly-in-smaps-v2.patch,
> and replace it with this.
>
.....

> diff -puN mm/hugetlb.c~smaps-pte-sizes mm/hugetlb.c
> --- a/mm/hugetlb.c~smaps-pte-sizes	2016-11-28 14:21:37.555519365 -0800
> +++ b/mm/hugetlb.c	2016-11-28 14:28:49.186234688 -0800
> @@ -2763,6 +2763,17 @@ void __init hugetlb_add_hstate(unsigned
>  					huge_page_size(h)/1024);
>  
>  	parsed_hstate = h;
> +
> +	/*
> +	 * PGD_SIZE isn't widely made available by architecures,
> +	 * so use PUD_SIZE*PTRS_PER_PUD as a substitute.
> +	 *
> +	 * Check for sizes that might be mapped by a PGD.  There
> +	 * are none of these known today, but be on the lookout.
> +	 * If this trips, we will need to update the mss->rss_*
> +	 * code in fs/proc/task_mmu.c.
> +	 */
> +	WARN_ON_ONCE((PAGE_SIZE << order) >= PUD_SIZE * PTRS_PER_PUD);
>  }

This will trip for ppc64 16GB hugepage.

For ppc64 we have the 16G at pgd level.

-aneesh

