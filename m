From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv3 11/11] mm: Use updated pmdp_invalidate() interface to
 track dirty/accessed bits
Date: Wed, 13 Dec 2017 13:13:36 +0300
Message-ID: <20171213101336.np2tin32o5ppvion@black.fi.intel.com>
References: <20170912153941.47012-1-kirill.shutemov@linux.intel.com>
 <20170912153941.47012-12-kirill.shutemov@linux.intel.com>
 <87tw07uz7p.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <87tw07uz7p.fsf@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
