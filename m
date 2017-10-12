Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdJLK5K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Oct 2017 06:57:10 -0400
Date: Thu, 12 Oct 2017 11:57:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 18/28] arm64/sve: Preserve SVE registers around EFI
 runtime service calls
Message-ID: <20171012105705.zbs3wokxhky36k4k@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-19-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507660725-7986-19-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171012105705.AWbu8pWBaIOiKM5fI73fF66qsO9W3mPfkPmn1dB7gcY@z>

On Tue, Oct 10, 2017 at 07:38:35PM +0100, Dave P Martin wrote:
> The EFI runtime services ABI allows EFI to make free use of the
> FPSIMD registers during EFI runtime service calls, subject to the
> callee-save requirements of the AArch64 procedure call standard.
> 
> However, the SVE architecture allows upper bits of the SVE vector
> registers to be zeroed as a side-effect of FPSIMD V-register
> writes.  This means that the SVE vector registers must be saved in
> their entirety in order to avoid data loss: non-SVE-aware EFI
> implementations cannot restore them correctly.
> 
> The non-IRQ case is already handled gracefully by
> kernel_neon_begin().  For the IRQ case, this patch allocates a
> suitable per-CPU stash buffer for the full SVE register state and
> uses it to preserve the affected registers around EFI calls.  It is
> currently unclear how the EFI runtime services ABI will be
> clarified with respect to SVE, so it safest to assume that the
> predicate registers and FFR must be saved and restored too.
> 
> No attempt is made to restore the restore the vector length after
> a call, for now.  It is deemed rather insane for EFI to change it,
> and contemporary EFI implementations certainly won't.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
