Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38555 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbdLMKOM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 05:14:12 -0500
Date: Wed, 13 Dec 2017 13:13:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv3 11/11] mm: Use updated pmdp_invalidate() interface to
 track dirty/accessed bits
Message-ID: <20171213101336.np2tin32o5ppvion@black.fi.intel.com>
References: <20170912153941.47012-1-kirill.shutemov@linux.intel.com>
 <20170912153941.47012-12-kirill.shutemov@linux.intel.com>
 <87tw07uz7p.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tw07uz7p.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20171213101336.hoLhdHPjeh7QgVaRtNfg4vSk2bDZ4XeqdJv0l6lGJK4@z>

On Wed, Sep 13, 2017 at 02:08:58AM +0000, Aneesh Kumar K.V wrote:
> @@ -2011,6 +2036,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			if (soft_dirty)
>  				entry = pte_mksoft_dirty(entry);
>  		}
> +		if (dirty)
> +			SetPageDirty(page + i);
>  		pte = pte_offset_map(&_pmd, addr);
>  		BUG_ON(!pte_none(*pte));
>  		set_pte_at(mm, addr, pte, entry);

The patch is fine. But we don't need to set every 4k dirty. We have single
dirty bit for whole THP. I'll change this part and sent the patch as part
of the series.

-- 
 Kirill A. Shutemov
