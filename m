Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47422 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750978AbdHQKE3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Aug 2017 06:04:29 -0400
Date: Thu, 17 Aug 2017 11:04:24 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 15/27] arm64/sve: Probe SVE capabilities and usable
 vector lengths
Message-ID: <20170817100424.GI6321@e103592.cambridge.arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-16-git-send-email-Dave.Martin@arm.com>
 <07268b07-c5f4-38d6-257d-5864cb6752c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07268b07-c5f4-38d6-257d-5864cb6752c1@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu
Message-ID: <20170817100424.XvUzNRk03RWIBVzf29eYP4AhBCzVvbCyyJ0Sekd_bZM@z>

On Wed, Aug 16, 2017 at 06:48:01PM +0100, Suzuki K Poulose wrote:
> On 09/08/17 13:05, Dave Martin wrote:
> >[This sender failed our fraud detection checks and may not be who they appear to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing]

Any idea what this is ^ ?  I don't know if this is caused by me or you,
but I only seem to see it on subthreads you've replied to.

> >This patch uses the cpufeatures framework to determine common SVE
> >capabilities and vector lengths, and configures the runtime SVE
> >support code appropriately.
> >
> >ZCR_ELx is not really a feature register, but it is convenient to
> >use it as a template for recording the maximum vector length
> >supported by a CPU, using the LEN field.  This field is similar to
> >a feature field in that it is a contiguous bitfield for which we
> >want to determine the minimum system-wide value.  This patch adds
> >ZCR as a pseudo-register in cpuinfo/cpufeatures, with appropriate
> >custom code to populate it.  Finding the minimum supported value of
> >the LEN field is left to the cpufeatures framework in the usual
> >way.
> >
> >The meaning of ID_AA64ZFR0_EL1 is not architecturally defined yet,
> >so for now we just require it to be zero.
> >
> >Note that much of this code is dormant and SVE still won't be used
> >yet, since system_supports_sve() remains hardwired to false.
> >
> >Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Dave,
> 
> The cpufeature bits look good to me, with one minor comment.
> 
> 
> >diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> >index bce95de..955c873 100644
> >--- a/arch/arm64/kernel/fpsimd.c
> >+++ b/arch/arm64/kernel/fpsimd.c
> 
> ...
> 
> >+void __init sve_setup(void)
> >+{
> >+       u64 zcr;
> >+       unsigned int max_vl;
> >+
> >+       if (!system_supports_sve())
> >+               return;
> >+
> >+       /*
> >+        * The architecture mandates 128-bit vectors be supported, and
> >+        * the code assumes elsewhere that sve_vq_map is non-empty:
> >+        */
> >+       BUG_ON(!test_bit(vq_to_bit(1), sve_vq_map));
> >+
> >+       sve_vq_map_finalised = true;
> 
> We have something local in cpufeature.c, sys_caps_initialised. May be we could
> reuse it here ? With or without that change, FWIW.

I'll take a look at that.  Inventing that here seemed a little ugly, and
this is all driven from the cpufreatures code anyway now which ensures a
certain ordering.

If I can reuse sys_caps_initialised for this, I will -- seems pointless
to reinvent it.

> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks
---Dave
