Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbdJLROm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Oct 2017 13:14:42 -0400
Date: Thu, 12 Oct 2017 18:14:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 25/28] arm64/sve: Detect SVE and activate runtime
 support
Message-ID: <20171012171436.m7l5jlvjnmdndpl7@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-26-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507660725-7986-26-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171012171437.K8I14g85_d3-gH2Le-O8PTcousEG2ySFCTc34QcG20o@z>

On Tue, Oct 10, 2017 at 07:38:42PM +0100, Dave P Martin wrote:
> This patch enables detection of hardware SVE support via the
> cpufeatures framework, and reports its presence to the kernel and
> userspace via the new ARM64_SVE cpucap and HWCAP_SVE hwcap
> respectively.
> 
> Userspace can also detect SVE using ID_AA64PFR0_EL1, using the
> cpufeatures MRS emulation.
> 
> When running on hardware that supports SVE, this enables runtime
> kernel support for SVE, and allows user tasks to execute SVE
> instructions and make of the of the SVE-specific user/kernel
> interface extensions implemented by this series.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
