Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43033 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932710AbdGTGFg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 02:05:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6K65Euq004057
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 02:05:36 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2btpjhrs1j-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 02:05:36 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 20 Jul 2017 16:05:34 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 11/62] powerpc: initial pkey plumbing
In-Reply-To: <1500177424-13695-12-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-12-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:34:10 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87shhrprtx.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Message-ID: <20170720060410._I5b7HFJV8-lWFRXlZt5Ke27L0lFVQPLT-_oQD0d72c@z>

Ram Pai <linuxram@us.ibm.com> writes:

> basic setup to initialize the pkey system. Only 64K kernel in HPT
> mode, enables the pkey system.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/Kconfig                   |   16 ++++++++++
>  arch/powerpc/include/asm/mmu_context.h |    5 +++
>  arch/powerpc/include/asm/pkeys.h       |   51 ++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_64.c         |    4 ++
>  arch/powerpc/mm/Makefile               |    1 +
>  arch/powerpc/mm/hash_utils_64.c        |    1 +
>  arch/powerpc/mm/pkeys.c                |   18 +++++++++++
>  7 files changed, 96 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/pkeys.h
>  create mode 100644 arch/powerpc/mm/pkeys.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index bf4391d..5c60fd6 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -855,6 +855,22 @@ config SECCOMP
>
>  	  If unsure, say Y. Only embedded should say N here.
>
> +config PPC64_MEMORY_PROTECTION_KEYS
> +	prompt "PowerPC Memory Protection Keys"
> +	def_bool y
> +	# Note: only available in 64-bit mode
> +	depends on PPC64 && PPC_64K_PAGES
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARCH_HAS_PKEYS
> +	---help---
> +	  Memory Protection Keys provides a mechanism for enforcing
> +	  page-based protections, but without requiring modification of the
> +	  page tables when an application changes protection domains.
> +
> +	  For details, see Documentation/vm/protection-keys.txt
> +
> +	  If unsure, say y.
> +
>  endmenu


Shouldn't this come as the last patch ? Or can we enable this config by
this patch ? If so what does it do ? Did you test boot each of this
patch to make sure we don't break git bisect ?

>
>  config ISA_DMA_API
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index da7e943..4b93547 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -181,5 +181,10 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  	/* by default, allow everything */


-aneesh
