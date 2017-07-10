Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753242AbdGJDHn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 23:07:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6A33ee8137373
        for <linux-arch@vger.kernel.org>; Sun, 9 Jul 2017 23:07:42 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjucuks98-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 09 Jul 2017 23:07:42 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 10 Jul 2017 13:07:39 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 34/38] procfs: display the protection-key number
 associated with a vma
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Date: Mon, 10 Jul 2017 08:37:28 +0530
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-ID: <1162ac6c-5e34-8a6c-fed2-6683d261352c@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170710030728.Kh_ivCYotgKYP36urkSDdDGX45JaTMf_EJHNJJz7GT0@z>

On 07/06/2017 02:52 AM, Ram Pai wrote:
> Display the pkey number associated with the vma in smaps of a task.
> The key will be seen as below:
> 
> ProtectionKey: 0
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/kernel/setup_64.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index f35ff9d..ebc82b3 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -37,6 +37,7 @@
>  #include <linux/memblock.h>
>  #include <linux/memory.h>
>  #include <linux/nmi.h>
> +#include <linux/pkeys.h>
>  
>  #include <asm/io.h>
>  #include <asm/kdump.h>
> @@ -745,3 +746,10 @@ static int __init disable_hardlockup_detector(void)
>  }
>  early_initcall(disable_hardlockup_detector);
>  #endif
> +
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS

Why not for X86 protection keys ?
