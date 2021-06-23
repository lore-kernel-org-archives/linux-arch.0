Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F86C4743C
	for <linux-arch@archiver.kernel.org>; Wed, 23 Jun 2021 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A996108E
	for <linux-arch@archiver.kernel.org>; Wed, 23 Jun 2021 11:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFWLGg (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 23 Jun 2021 07:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFWLGf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 07:06:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E85E61003;
        Wed, 23 Jun 2021 11:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624446258;
        bh=SQLZ3jEqT4yhyhpj0Bb9UFclPy9A7MyuqA/xQ21E19o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFel0oGOMMRKsUQpOzA8E0CCodJoyPdxcszRZjPwq2EF6srqWdV01nWToiHko05qr
         z4OoIBK2qzIUUUqLi/+1Gvaeq1z/zXhEREhS7P6V+BZdsMAMzIgeofMC0LMKzq5y+n
         1csrxIqsmn/WulaMO7Mbf9WQjRdjHAJawSFsK2Y0e6dY6WVzN2K/wPJVVzwSvUO86F
         mW72uxO54TkbohQpB88ly/TTkjX7bt7ioUcsI+SbQ3wM1fv11Tz40VtNvJ94aR1DB1
         OC7Rqt8S2FO3m8tUJGaII25RYFNWSq8XxR5rNaJ/nNUETYfy/n4Fvz8eabCU7nHi8c
         SIOV/J/fx2MjQ==
Date:   Wed, 23 Jun 2021 12:04:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        aneesh.kumar@linux.ibm.com, Marc Zyngier <maz@kernel.org>,
        steven.price@arm.com, Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Xiexiangyou <xiexiangyou@huawei.com>, liushixin2@huawei.com,
        huyaqin <huyaqin1@huawei.com>, zhurui3@huawei.com
Subject: Re: [PATCH v1] arm64: tlb: fix the TTL value of tlb_get_level
Message-ID: <20210623110412.GA32177@willie-the-truck>
References: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 23, 2021 at 03:05:22PM +0800, Zhenyu Ye wrote:
> The TTL field indicates the level of page table walk holding the *leaf*
> entry for the address being invalidated. But currently, the TTL field
> may be set to an incorrent value in the following stack:
> 
> pte_free_tlb
>     __pte_free_tlb
>         tlb_remove_table
>             tlb_table_invalidate
>                 tlb_flush_mmu_tlbonly
>                     tlb_flush
> 
> In this case, we just want to flush a PTE page, but the tlb->cleared_pmds
> is set and we get tlb_level = 2 in the tlb_get_level() function. This may
> cause some unexpected problems.
> 
> This patch set the TTL field to 0 if tlb->freed_tables is set. The
> tlb->freed_tables indicates page table pages are freed, not the leaf
> entry.
> 
> Fixes: c4ab2cbc1d87 ("arm64: tlb: Set the TTL field in flush_tlb_range")
> Reported-by: ZhuRui <zhurui3@huawei.com>
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/tlb.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 61c97d3b58c7..c995d1f4594f 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -28,6 +28,10 @@ static void tlb_flush(struct mmu_gather *tlb);
>   */
>  static inline int tlb_get_level(struct mmu_gather *tlb)
>  {
> +	/* The TTL field is only valid for the leaf entry. */
> +	if (tlb->freed_tables)
> +		return 0;
> +
>  	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
>  				   tlb->cleared_puds ||
>  				   tlb->cleared_p4ds))

Thanks. I can't see a better way around this, so I'll queue the patch.
The stage-2 page-table code looks ok afaict, but please can you check it
too?

Cheers,

Will
