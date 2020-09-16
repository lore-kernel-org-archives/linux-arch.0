Return-Path: <SRS0=Mp4i=CZ=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8422C43461
	for <linux-arch@archiver.kernel.org>; Wed, 16 Sep 2020 16:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D082245F
	for <linux-arch@archiver.kernel.org>; Wed, 16 Sep 2020 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600274504;
	bh=SG4MuQp/zwduxe3VaSSRDORy0X7NqWtWqo77LpwkLVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KedvFatC4y2P5L+vd20VHeUYHAd7DZpUca2MhWdzDJzr2rwFXhU7zeGuUvGq5jl3k
	 y15sXTkcf2gTRiCM6XZC7EjmVtuA6hqyn3TFTicvgM3Fhe7dwu9UVNGj3xPNym0skJ
	 V/gwdL11rjEO5ngsqW/MdC7cQg09ss7atVlhoGfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIPQlj (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Sep 2020 12:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgIPQe2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Sep 2020 12:34:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C66EC22225;
        Wed, 16 Sep 2020 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600259962;
        bh=SG4MuQp/zwduxe3VaSSRDORy0X7NqWtWqo77LpwkLVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clfcM+a6rpyIvjE9f/xKkFEArCvnhlB83pHLnB4FRf9h/LWBgsDNWuLET6KuYTnlg
         ipu1/I8F0W3MU7Xv6S7hEF6BswSLvz2VZlaBcO+rZHonVu7dRFYKA54uWJ7VdXESG3
         ryxftx2FjhHc+UTLAyC8ogG/hxgTSlN2VjehXuzo=
Date:   Wed, 16 Sep 2020 13:39:14 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 00/10] Independent per-CPU data section for nVHE
Message-ID: <20200916123913.GA28056@willie-the-truck>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200914174008.GA25238@willie-the-truck>
 <20200916115404.rhv4dkyjz35e4x25@google.com>
 <20200916122412.elxfxbdygvmdgrj5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916122412.elxfxbdygvmdgrj5@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 16, 2020 at 01:24:12PM +0100, David Brazdil wrote:
> > I was also wondering about another approach - using the PERCPU_SECTION macro
> > unchanged in the hyp linker script. It would lay out a single .data..percpu and
> > we would then prefix it with .hyp and the symbols with __kvm_nvhe_ as with
> > everything else. WDYT? Haven't tried that yet, could be a naive idea. 
> 
> Seems to work. Can't use PERCPU_SECTION directly because then we couldn't
> rename it in the same linker script, but if we just unwrap that one layer
> we can use PERCPU_INPUT. No global macro changes needed.
> 
> Let me know what you think.
> 
> ------8<------
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 5904a4de9f40..9e6bf21268f1 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -195,11 +195,9 @@ SECTIONS
>         PERCPU_SECTION(L1_CACHE_BYTES)
> 
>         /* KVM nVHE per-cpu section */
> -       #undef PERCPU_SECTION_NAME
> -       #undef PERCPU_SYMBOL_NAME
> -       #define PERCPU_SECTION_NAME(suffix)     CONCAT3(.hyp, PERCPU_SECTION_BASE_NAME, suffix)
> -       #define PERCPU_SYMBOL_NAME(name)        __kvm_nvhe_ ## name
> -       PERCPU_SECTION(L1_CACHE_BYTES)
> +       . = ALIGN(PAGE_SIZE);
> +       .hyp.data..percpu : { *(.hyp.data..percpu) }
> +       . = ALIGN(PAGE_SIZE);
> 
>         .rela.dyn : ALIGN(8) {
>                 *(.rela .rela*)
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> index 7d8c3fa004f4..1d8e4f7edc29 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> @@ -4,6 +4,10 @@
>   * Written by David Brazdil <dbrazdil@google.com>
>   */
> 
> +#include <asm-generic/vmlinux.lds.h>
> +#include <asm/cache.h>
> +#include <asm/memory.h>
> +
>  /*
>   * Defines an ELF hyp section from input section @NAME and its subsections.
>   */
> @@ -11,9 +15,9 @@
> 
>  SECTIONS {
>         HYP_SECTION(.text)
> -       HYP_SECTION(.data..percpu)
> -       HYP_SECTION(.data..percpu..first)
> -       HYP_SECTION(.data..percpu..page_aligned)
> -       HYP_SECTION(.data..percpu..read_mostly)
> -       HYP_SECTION(.data..percpu..shared_aligned)
> +
> +       .hyp..data..percpu : {

Too many '.'s here?

> +               __per_cpu_load = .;

I don't think we need this symbol.

Otherwise, idea looks good to me. Can you respin like this, but also
incorporating some of the cleanup in the diff I posted, please?

Will
