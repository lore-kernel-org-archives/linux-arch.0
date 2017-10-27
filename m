Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752575AbdJ0M41 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Oct 2017 08:56:27 -0400
Date: Fri, 27 Oct 2017 13:56:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 16/28] arm64/sve: Probe SVE capabilities and usable
 vector lengths
Message-ID: <20171027125622.75rqvb2kyr4wqhr4@armageddon.cambridge.arm.com>
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
 <1509101470-7881-17-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1509101470-7881-17-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171027125622.DHvu7WgDfGUmc-Fjbf4pGBhpAqGbSmGlAuojojoJb58@z>

On Fri, Oct 27, 2017 at 11:50:58AM +0100, Dave P Martin wrote:
> This patch uses the cpufeatures framework to determine common SVE
> capabilities and vector lengths, and configures the runtime SVE
> support code appropriately.
> 
> ZCR_ELx is not really a feature register, but it is convenient to
> use it as a template for recording the maximum vector length
> supported by a CPU, using the LEN field.  This field is similar to
> a feature field in that it is a contiguous bitfield for which we
> want to determine the minimum system-wide value.  This patch adds
> ZCR as a pseudo-register in cpuinfo/cpufeatures, with appropriate
> custom code to populate it.  Finding the minimum supported value of
> the LEN field is left to the cpufeatures framework in the usual
> way.
> 
> The meaning of ID_AA64ZFR0_EL1 is not architecturally defined yet,
> so for now we just require it to be zero.
> 
> Note that much of this code is dormant and SVE still won't be used
> yet, since system_supports_sve() remains hardwired to false.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
