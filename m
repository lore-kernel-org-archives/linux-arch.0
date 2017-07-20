From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 05/62] powerpc: capture the PTE format changes in the dump pte report
Date: Thu, 20 Jul 2017 11:26:28 +0530
Message-ID: <877ez3r6r7.fsf@skywalker.in.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-6-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932377AbdGTF4o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 01:56:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6K5s2mo119834
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:56:43 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2btp4jscrq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:56:43 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 20 Jul 2017 15:56:41 +1000
In-Reply-To: <1500177424-13695-6-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org

Ram Pai <linuxram@us.ibm.com> writes:

> The H_PAGE_F_SECOND,H_PAGE_F_GIX are not in the 64K main-PTE.
> capture these changes in the dump pte report.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/dump_linuxpagetables.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index 44fe483..5627edd 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -213,7 +213,7 @@ struct flag_info {
>  		.val	= H_PAGE_4K_PFN,
>  		.set	= "4K_pfn",
>  	}, {
> -#endif
> +#else /* CONFIG_PPC_64K_PAGES */
>  		.mask	= H_PAGE_F_GIX,
>  		.val	= H_PAGE_F_GIX,
>  		.set	= "f_gix",
> @@ -224,6 +224,7 @@ struct flag_info {
>  		.val	= H_PAGE_F_SECOND,
>  		.set	= "f_second",
>  	}, {
> +#endif /* CONFIG_PPC_64K_PAGES */
>  #endif
>  		.mask	= _PAGE_SPECIAL,
>  		.val	= _PAGE_SPECIAL,
> -- 
> 1.7.1
