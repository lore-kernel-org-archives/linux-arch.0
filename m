Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54223 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935930AbdCXQ50 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Mar 2017 12:57:26 -0400
Date: Fri, 24 Mar 2017 09:57:24 -0700
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 00/17] PCI resource mmap cleanup
Message-ID: <20170324165724.GA27823@intel.com>
References: <cover.1490188942.git.dwmw2@infradead.org>
 <1490355633.11856.17.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1490355633.11856.17.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20170324165724.7eQDCMeFtQQPteEuA9ItX28obivL9POp3y3aJTDPK-A@z>

On Fri, Mar 24, 2017 at 11:40:33AM +0000, David Woodhouse wrote:
> That leaves IA64 as the last holdout, as the selection of vm_page_prot
> there is rather complicated:
> 
> 	prot = phys_mem_access_prot(NULL, vma->vm_pgoff, size,
> 				    vma->vm_page_prot);
> 
> 	/*
> 	 * If the user requested WC, the kernel uses UC or WC for this region,
> 	 * and the chipset supports WC, we can use WC. Otherwise, we have to
> 	 * use the same attribute the kernel uses.
> 	 */
> 	if (write_combine &&
> 	    ((pgprot_val(prot) & _PAGE_MA_MASK) == _PAGE_MA_UC ||
> 	     (pgprot_val(prot) & _PAGE_MA_MASK) == _PAGE_MA_WC) &&
> 	    efi_range_is_wc(vma->vm_start, vma->vm_end - vma->vm_start))
> 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> 	else
> 		vma->vm_page_prot = prot;
> 
> 
> But I suspect it's *overcomplicated*, as the kernel should only ever be
> mapping PCI memory BARs as UC or WC in the first place, so the middle
> two checks in the if (write_combine…) condition are redundant.

Agreed.

> And if the efi_range_is_wc() check isn't gratuitous, perhaps that
> should be in the generic code whenever CONFIG_EFI is set?

Sounds dubious whether EFI could even get this right.  The efi
memory map table is static, but we could remap a BAR to a different
spot. Does the efi map have entries for all the places that you
could remap a BAR?  Isn't it more likely a property of the device
whether it supports WC?

-Tony
