Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33887 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbbH0Pc5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2015 11:32:57 -0400
Received: by widdq5 with SMTP id dq5so81794498wid.1
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2015 08:32:56 -0700 (PDT)
Date: Thu, 27 Aug 2015 18:32:54 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 04/11] ARCv2: mm: THP support
Message-ID: <20150827153254.GA21103@node.dhcp.inet.fi>
References: <1440666194-21478-1-git-send-email-vgupta@synopsys.com>
 <1440666194-21478-5-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440666194-21478-5-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, arc-linux-dev@synopsys.com
Message-ID: <20150827153254.PhWG6KmFB-IicGzc2jk8DX-09nH8ntcKSWItlCLM_Bs@z>

On Thu, Aug 27, 2015 at 02:33:07PM +0530, Vineet Gupta wrote:
> +pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
> +{
> +	struct list_head *lh;
> +	pgtable_t pgtable;
> +	pte_t *ptep;
> +
> +	assert_spin_locked(&mm->page_table_lock);
> +
> +	pgtable = pmd_huge_pte(mm, pmdp);
> +	lh = (struct list_head *) pgtable;
> +	if (list_empty(lh))
> +		pmd_huge_pte(mm, pmdp) = (pgtable_t) NULL;
> +	else {
> +		pmd_huge_pte(mm, pmdp) = (pgtable_t) lh->next;
> +		list_del(lh);
> +	}

Side question: why pgtable_t is unsigned long on ARC and not struct page *
or pte_t *, like on other archs? We could avoid these casts.

-- 
 Kirill A. Shutemov
