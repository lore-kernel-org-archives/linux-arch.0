From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC][PATCH 33/35] asm-generic/ptemap.h for HIGHPTE users
Date: Fri, 1 May 2009 10:51:57 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA39EF467E5@orsmsx505.amr.corp.intel.com>
References: <20090501144201.D31EF417@kernel> <20090501144252.A2BDDE6B@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7699 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbZEARv6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 13:51:58 -0400
In-Reply-To: <20090501144252.A2BDDE6B@kernel>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> diff -puN include/asm-generic/ptemap.h~asm-generic-ptemap-h-highpte include/asm-generic/ptemap.h
> +#ifdef CONFIG_HIGHPTE
> +#include <asm/highmem.h>
> +#define pte_offset_map(dir, address) \
> +     ((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
> +#define pte_offset_map_nested(dir, address) \
> +     ((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
> +#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
> +#define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
> +
> +#else /* !CONFIG_HIGHPTE */
> +
> #define pte_offset_map(dir,addr)      pte_offset_kernel((dir),(addr))
> #define pte_offset_map_nested(dir,addr)       pte_offset_kernel((dir),(addr))
> #define pte_unmap(pte)                        do { } while (0)

You need to add a closing #endif here.

-Tony
