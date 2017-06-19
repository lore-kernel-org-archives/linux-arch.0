From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 2/3] mm: Do not loose dirty and access bits in
 pmdp_invalidate()
Date: Mon, 19 Jun 2017 16:29:13 +0300
Message-ID: <20170619132913.se67bp4addreqovn@node.shutemov.name>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
 <20170615145224.66200-3-kirill.shutemov@linux.intel.com>
 <20170616134041.GF11676@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35866 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdFSN3R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 09:29:17 -0400
Received: by mail-lf0-f66.google.com with SMTP id x81so10526709lfb.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2017 06:29:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170616134041.GF11676@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, Jun 16, 2017 at 03:40:41PM +0200, Andrea Arcangeli wrote:
> On Thu, Jun 15, 2017 at 05:52:23PM +0300, Kirill A. Shutemov wrote:
> > -void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> > +pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> >  		     pmd_t *pmdp)
> >  {
> > -	pmd_t entry = *pmdp;
> > -	set_pmd_at(vma->vm_mm, address, pmdp, pmd_mknotpresent(entry));
> > -	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> > +	pmd_t old = pmdp_establish(pmdp, pmd_mknotpresent(*pmdp));
> > +	if (pmd_present(old))
> > +		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> > +	return old;
> >  }
> >  #endif
> 
> The pmd_present() check added above is superflous because there's no
> point to call pmdp_invalidate if the pmd is not present (present as in
> pmd_present) already. pmd_present returns true if _PAGE_PSE is set
> and it was always set before calling pmdp_invalidate.
> 
> It looks like we could skip the flush if _PAGE_PRESENT is not set
> (i.e. for example if the pmd is PROTNONE) but that's not what the above
> pmd_present will do.

You are right. We seems don't have a generic way to check the entry is
present to CPU.

I guess I'll drop the check then.

-- 
 Kirill A. Shutemov
