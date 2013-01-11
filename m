From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 15/44] metag: Huge TLB
Date: Fri, 11 Jan 2013 09:58:34 +0000
Message-ID: <50EFE24A.8070903@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <1357831872-29451-16-git-send-email-james.hogan@imgtec.com> <50EEF2E9.2080302@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56754 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab3AKJ6h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Jan 2013 04:58:37 -0500
In-Reply-To: <50EEF2E9.2080302@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 10/01/13 16:57, Dave Hansen wrote:
> On 01/10/2013 07:30 AM, James Hogan wrote:
>> +pte_t *huge_pte_alloc(struct mm_struct *mm,
>> +			unsigned long addr, unsigned long sz)
>> +{
>> +	pgd_t *pgd;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +	pte_t *pte;
>> +
>> +	pgd = pgd_offset(mm, addr);
>> +	pud = pud_offset(pgd, addr);
>> +	pmd = pmd_offset(pud, addr);
>> +	pte = pte_alloc_map(mm, NULL, pmd, addr);
>> +	pgd->pgd &= ~_PAGE_SZ_MASK;
>> +	pgd->pgd |= _PAGE_SZHUGE;
>> +
>> +	return pte;
>> +}
> 
> I'd be a bit surprised if you don't have to check for NULL during the
> walk down the page tables.  Is there a special reason on your
> architecture that this is unnecessary?
> 
> (There are several of these, not just this one).
> 

Meta only has 2 levels of page tables which map to the linux levels.
asm/pgtable.h includes asm-generic/pgtable-nopmd.h, which includes
asm-generic/pgtable-nopud.h, so the pmd and pud levels get folded into
the pgd.

Cheers
James
