Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:38841 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbcDKL27 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2016 07:28:59 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <cornelia.huck@de.ibm.com>;
	Mon, 11 Apr 2016 12:28:57 +0100
Date: Mon, 11 Apr 2016 13:28:37 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 13/19] s390: get rid of superfluous __GFP_REPEAT
Message-ID: <20160411132837.3cba168f.cornelia.huck@de.ibm.com>
In-Reply-To: <1460372892-8157-14-git-send-email-mhocko@kernel.org>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
	<1460372892-8157-14-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160411112837.rFxOIgiZUurms81r24Dn0AS9qu47Scy2RufDfAqpStI@z>

On Mon, 11 Apr 2016 13:08:06 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
> 
> arch_dup_task_struct uses __GFP_REPEAT for fpu_regs_size which is either
> sizeof(__vector128) * __NUM_VXRS = 4069B resp.
> sizeof(freg_t) * __NUM_FPRS = 1024B AFAICS. page_table_alloc then uses
> the flag for a single page allocation. This means that this flag has
> never been actually useful here because it has always been used only for
> PAGE_ALLOC_COSTLY requests.
> 
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>

Let's cc: Martin/Heiko instead :)

> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  arch/s390/kernel/process.c | 2 +-
>  arch/s390/mm/pgalloc.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index f8e79824e284..1837a1901d4b 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -102,7 +102,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  	 */
>  	fpu_regs_size = MACHINE_HAS_VX ? sizeof(__vector128) * __NUM_VXRS
>  				       : sizeof(freg_t) * __NUM_FPRS;
> -	dst->thread.fpu.regs = kzalloc(fpu_regs_size, GFP_KERNEL|__GFP_REPEAT);
> +	dst->thread.fpu.regs = kzalloc(fpu_regs_size, GFP_KERNEL);
>  	if (!dst->thread.fpu.regs)
>  		return -ENOMEM;
> 
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index f6c3de26cda8..3f716741797a 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -198,7 +198,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  			return table;
>  	}
>  	/* Allocate a fresh page */
> -	page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
> +	page = alloc_page(GFP_KERNEL);
>  	if (!page)
>  		return NULL;
>  	if (!pgtable_page_ctor(page)) {

