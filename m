Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53071 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751454AbdG0UlD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jul 2017 16:41:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6RKex5J092706
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2017 16:41:03 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bykvys3u3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2017 16:41:03 -0400
Received: from localhost
        by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Thu, 27 Jul 2017 17:41:00 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-16-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 15/62] powerpc: helper functions to initialize AMR, IAMR and UMOR registers
In-reply-to: <1500177424-13695-16-git-send-email-linuxram@us.ibm.com>
Date: Thu, 27 Jul 2017 17:40:44 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <877eyt4nqr.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
Message-ID: <20170727204044.4Yw3rTtoXgJeUkIGi4649P9q9rc8MwkfDzDjBK0mdxY@z>


Ram Pai <linuxram@us.ibm.com> writes:

> Introduce helper functions that can initialize the bits in the AMR,
> IAMR and UMOR register; the bits that correspond to the given pkey.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

s/UMOR/UAMOR/ here and in the subject as well.

> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -16,3 +16,47 @@
>  #include <linux/pkeys.h>                /* PKEY_*                       */
>
>  bool pkey_inited;
> +#define pkeyshift(pkey) ((arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY)
> +
> +static inline void init_amr(int pkey, u8 init_bits)
> +{
> +	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> +	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> +
> +	write_amr(old_amr | new_amr_bits);
> +}
> +
> +static inline void init_iamr(int pkey, u8 init_bits)
> +{
> +	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> +	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> +
> +	write_amr(old_iamr | new_iamr_bits);
> +}

init_iamr should call write_iamr, not write_amr.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
