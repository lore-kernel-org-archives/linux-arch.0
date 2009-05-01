From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: RE: [RFC][PATCH 33/35] asm-generic/ptemap.h for HIGHPTE users
Date: Fri, 01 May 2009 11:10:52 -0700
Message-ID: <1241201452.29485.206.camel@nimitz>
References: <20090501144201.D31EF417@kernel>
	 <20090501144252.A2BDDE6B@kernel>
	 <57C9024A16AD2D4C97DC78E552063EA39EF467E5@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48774 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759822AbZEASKy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 14:10:54 -0400
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA39EF467E5@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2009-05-01 at 10:51 -0700, Luck, Tony wrote:
> > diff -puN include/asm-generic/ptemap.h~asm-generic-ptemap-h-highpte include/asm-generic/ptemap.h
> > +#ifdef CONFIG_HIGHPTE
> > +#include <asm/highmem.h>
> > +#define pte_offset_map(dir, address) \
> > +     ((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
> > +#define pte_offset_map_nested(dir, address) \
> > +     ((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
> > +#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
> > +#define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
> > +
> > +#else /* !CONFIG_HIGHPTE */
> > +
> > #define pte_offset_map(dir,addr)      pte_offset_kernel((dir),(addr))
> > #define pte_offset_map_nested(dir,addr)       pte_offset_kernel((dir),(addr))
> > #define pte_unmap(pte)                        do { } while (0)
> 
> You need to add a closing #endif here.

Fixed, thanks.

-- Dave
