Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48573 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753014AbdG1VAU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jul 2017 17:00:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6SKxisX024632
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2017 17:00:20 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c0cs681uu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2017 17:00:20 -0400
Received: from localhost
        by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Fri, 28 Jul 2017 18:00:17 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-28-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 27/62] powerpc: helper to validate key-access permissions of a pte
In-reply-to: <1500177424-13695-28-git-send-email-linuxram@us.ibm.com>
Date: Fri, 28 Jul 2017 18:00:02 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87tw1we0q5.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
Message-ID: <20170728210002.igQ32-IxKIBvGJKlLtDMy2zD9hSDxmjSRyJyoEJ3bzI@z>


Ram Pai <linuxram@us.ibm.com> writes:
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -201,3 +201,36 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
>  	 */
>  	return vma_pkey(vma);
>  }
> +
> +static bool pkey_access_permitted(int pkey, bool write, bool execute)
> +{
> +	int pkey_shift;
> +	u64 amr;
> +
> +	if (!pkey)
> +		return true;
> +
> +	pkey_shift = pkeyshift(pkey);
> +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> +		return true;
> +
> +	if (execute && !(read_iamr() & (IAMR_EX_BIT << pkey_shift)))
> +		return true;
> +
> +	if (!write) {
> +		amr = read_amr();
> +		if (!(amr & (AMR_RD_BIT << pkey_shift)))
> +			return true;
> +	}
> +
> +	amr = read_amr(); /* delay reading amr uptil absolutely needed */

Actually, this is causing amr to be read twice in case control enters
the "if (!write)" block above but doesn't enter the other if block nested
in it.

read_amr should be called only once, right before "if (!write)".

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
