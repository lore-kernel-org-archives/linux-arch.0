Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751744AbdJKO3z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 10:29:55 -0400
Date: Wed, 11 Oct 2017 15:29:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 09/28] arm64/sve: Signal frame and context structure
 definition
Message-ID: <20171011142950.zdhpaenvz4u5oyc3@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-10-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507660725-7986-10-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171011142951.v6_cWGmpYXnJ-AB91NQ_blRzFyL-jMfeSpWDExZVsBc@z>

On Tue, Oct 10, 2017 at 07:38:26PM +0100, Dave P Martin wrote:
> This patch defines the representation that will be used for the SVE
> register state in the signal frame, and implements support for
> saving and restoring the SVE registers around signals.
> 
> The same layout will also be used for the in-kernel task state.
> 
> Due to the variability of the SVE vector length, it is not possible
> to define a fixed C struct to describe all the registers.  Instead,
> Macros are defined in sigcontext.h to facilitate access to the
> parts of the structure.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
