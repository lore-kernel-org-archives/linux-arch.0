Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34747 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933105AbdGTFwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 01:52:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6K5oKDC058957
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:52:07 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2btpg48gj6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:52:07 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 20 Jul 2017 15:52:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 01/62] powerpc: Free up four 64K PTE bits in 4K backed HPTE pages
In-Reply-To: <1500177424-13695-2-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-2-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:21:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87d18vr6yw.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Message-ID: <20170720055151.ZXjYgUqQDo8ETAgTXJiJgP_shZomnQNJSSKI6OayWzI@z>


.....

>  	/*
> @@ -116,8 +104,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * On hash insert failure we use old pte value and we don't
>  		 * want slot information there if we have a insert failure.
>  		 */
> -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> +		old_pte &= ~(H_PAGE_HASHPTE);
> +		new_pte &= ~(H_PAGE_HASHPTE);
>  		goto htab_insert_hpte;
>  	}

With the current path order and above hunk we will breaks the bisect I guess. With the above, when
we convert a 64k hpte to 4khpte, since this is the first patch, we
should clear that H_PAGE_F_GIX and H_PAGE_F_SECOND. We still use them
for 64k. I guess you should move this hunk to second patch.


-aneesh
