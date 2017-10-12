Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdJLRLW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Oct 2017 13:11:22 -0400
Date: Thu, 12 Oct 2017 18:11:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 20/28] arm64/sve: Add prctl controls for userspace
 vector length management
Message-ID: <20171012171117.fn4rx4wxps6tcve5@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-21-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507660725-7986-21-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171012171117.qOLnlnT_sgNbOmeXjQ_rtrLW4DgF1gkDSeUqdJ73XCs@z>

On Tue, Oct 10, 2017 at 07:38:37PM +0100, Dave P Martin wrote:
> This patch adds two arm64-specific prctls, to permit userspace to
> control its vector length:
> 
>  * PR_SVE_SET_VL: set the thread's SVE vector length and vector
>    length inheritance mode.
> 
>  * PR_SVE_GET_VL: get the same information.
> 
> Although these calls shadow instruction set features in the SVE
> architecture, these prctls provide additional control: the vector
> length inheritance mode is Linux-specific and nothing to do with
> the architecture, and the architecture does not permit EL0 to set
> its own vector length directly.  Both can be used in portable tools
> without requiring the use of SVE instructions.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
