From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 19/19] arm64: mte: Add Memory Tagging Extension
 documentation
Date: Wed, 11 Mar 2020 15:17:54 -0700
Message-ID: <0857cca0-9f75-398d-e755-f645d2d8a594@linaro.org>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-20-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53017 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgCKWR7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2020 18:17:59 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so1653658pjq.2
        for <linux-arch@vger.kernel.org>; Wed, 11 Mar 2020 15:17:58 -0700 (PDT)
In-Reply-To: <20200226180526.3272848-20-catalin.marinas@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>

On 2/26/20 10:05 AM, Catalin Marinas wrote:
> +    /*
> +     * From include/uapi/linux/prctl.h
> +     */
> +    #define PR_SET_TAGGED_ADDR_CTRL 55
> +    #define PR_GET_TAGGED_ADDR_CTRL 56
> +    # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
> +    # define PR_MTE_TCF_SHIFT       1
> +    # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TAG_SHIFT       3
> +    # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)

Is there a reason not to include TCMA into the set of bits that userland can
control with this prcrl?

I know that ordinarily TCR_ELx requires expensive syncing, but for this
particular field there is a note about "software may change this control bit on
a context switch".  Which I take to mean that the usual TLB-related syncing may
be omitted.


r~
