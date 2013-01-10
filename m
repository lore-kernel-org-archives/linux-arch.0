From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 15/44] metag: Huge TLB
Date: Thu, 10 Jan 2013 08:57:13 -0800
Message-ID: <50EEF2E9.2080302@linux.vnet.ibm.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <1357831872-29451-16-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:38369 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab3AJQ5t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jan 2013 11:57:49 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dave@linux.vnet.ibm.com>;
	Thu, 10 Jan 2013 09:57:48 -0700
In-Reply-To: <1357831872-29451-16-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 01/10/2013 07:30 AM, James Hogan wrote:
> +pte_t *huge_pte_alloc(struct mm_struct *mm,
> +			unsigned long addr, unsigned long sz)
> +{
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	pgd = pgd_offset(mm, addr);
> +	pud = pud_offset(pgd, addr);
> +	pmd = pmd_offset(pud, addr);
> +	pte = pte_alloc_map(mm, NULL, pmd, addr);
> +	pgd->pgd &= ~_PAGE_SZ_MASK;
> +	pgd->pgd |= _PAGE_SZHUGE;
> +
> +	return pte;
> +}

I'd be a bit surprised if you don't have to check for NULL during the
walk down the page tables.  Is there a special reason on your
architecture that this is unnecessary?

(There are several of these, not just this one).
