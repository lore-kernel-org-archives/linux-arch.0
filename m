Return-Path: <SRS0=7t7o=EE=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04111C388F7
	for <linux-arch@archiver.kernel.org>; Thu, 29 Oct 2020 00:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD15420791
	for <linux-arch@archiver.kernel.org>; Thu, 29 Oct 2020 00:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgJ2Azr (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgJ1WRk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C65246AE;
        Wed, 28 Oct 2020 11:12:07 +0000 (UTC)
Date:   Wed, 28 Oct 2020 11:12:04 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201028111204.GB13345@gaia>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027215118.27003-3-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 09:51:14PM +0000, Will Deacon wrote:
> +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +	return has_cpuid_feature(entry, scope) || __allow_mismatched_32bit_el0;
> +}
> +
>  static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
>  {
>  	bool has_sre;
> @@ -1803,7 +1851,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.desc = "32-bit EL0 Support",
>  		.capability = ARM64_HAS_32BIT_EL0,
>  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> -		.matches = has_cpuid_feature,
> +		.matches = has_32bit_el0,

Ah, so this one reports 32-bit EL0 support even if no CPU actually
supports 32-bit (passing the command line option on TX2 would come up
with 32-bit EL0 in dmesg). I'd rather hide the .desc above and print the
information elsewhere when have at least one CPU supporting this.

-- 
Catalin
