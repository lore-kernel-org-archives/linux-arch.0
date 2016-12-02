Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60273 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753821AbcLBTB3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2016 14:01:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uB2GEt8U108104
        for <linux-arch@vger.kernel.org>; Fri, 2 Dec 2016 11:15:06 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2737r2yt64-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2016 11:15:06 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Fri, 2 Dec 2016 09:15:05 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] proc: mm: export PTE sizes directly in smaps (v3)
In-Reply-To: <20161129201703.CE9D5054@viggo.jf.intel.com>
References: <20161129201703.CE9D5054@viggo.jf.intel.com>
Date: Fri, 02 Dec 2016 21:44:57 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <874m2me29q.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
Cc: hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com, khandual@linux.vnet.ibm.com, vbabka@suse.cz, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20161202161457.XMgNbAfBSkfg2EPsKIz1tvZMEAEpHPHVSb351Jbje8U@z>

Dave Hansen <dave@sr71.net> writes:

  
>  #ifdef CONFIG_HUGETLB_PAGE
> +/*
> + * Most architectures have a 1:1 mapping of PTEs to hugetlb page
> + * sizes, but there are some outliers like arm64 that use
> + * multiple hardware PTEs to make a hugetlb "page".  Do not
> + * assume that all 'hpage_size's are not exactly at a page table
> + * size boundary.  Instead, accept arbitrary 'hpage_size's and
> + * assume they are made up of the next-smallest size.  We do not
> + * handle PGD-sized hpages and hugetlb_add_hstate() will WARN()
> + * if it sees one.
> + *
> + * Note also that the page walker code only calls us once per
> + * huge 'struct page', *not* once per PTE in the page tables.
> + */
> +static void smaps_hugetlb_present_hpage(struct mem_size_stats *mss,
> +					unsigned long hpage_size)
> +{
> +	if (hpage_size >= PUD_SIZE)
> +		mss->rss_pud += hpage_size;
> +	else if (hpage_size >= PMD_SIZE)
> +		mss->rss_pmd += hpage_size;
> +	else
> +		mss->rss_pte += hpage_size;
> +}

some powerpc platforms have multiple page table entries mapping the same
hugepage and on other, we have a page table entry pointing to something
called hugepaeg directory mapping a set of hugepage. So I am not sure
the above will work for all those ?

Also do we derive pte@<size value> correctly there ?

-aneesh

