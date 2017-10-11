Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbdJKO2Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 10:28:24 -0400
Date: Wed, 11 Oct 2017 15:28:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 07/28] arm64/sve: Low-level SVE architectural state
 manipulation functions
Message-ID: <20171011142819.jheh4jwb347demj6@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-8-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507660725-7986-8-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171011142819.RRsa48P_SiF7XLLyBXTae67fcQsce9nby3D2BxdN7I4@z>

On Tue, Oct 10, 2017 at 07:38:24PM +0100, Dave P Martin wrote:
> Manipulating the SVE architectural state, including the vector and
> predicate registers, first-fault register and the vector length,
> requires the use of dedicated instructions added by SVE.
> 
> This patch adds suitable assembly functions for saving and
> restoring the SVE registers and querying the vector length.
> Setting of the vector length is done as part of register restore.
> 
> Since people building kernels may not all get an SVE-enabled
> toolchain for a while, this patch uses macros that generate
> explicit opcodes in place of assembler mnemonics.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(not adding reviewed-by as I haven't checked the instruction encodings,
I just trust you to be correct ;))
