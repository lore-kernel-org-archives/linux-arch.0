Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33772 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbdJKO3N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 10:29:13 -0400
Date: Wed, 11 Oct 2017 15:29:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 08/28] arm64/sve: Kconfig update and conditional
 compilation support
Message-ID: <20171011142908.gwgxegzy2kyb5i3t@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-9-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507660725-7986-9-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171011142908.xeCiaU26H7WyIYiy1FxeFLPlW9chChcyJ2g6I9uSAqU@z>

On Tue, Oct 10, 2017 at 07:38:25PM +0100, Dave P Martin wrote:
> This patch adds CONFIG_ARM64_SVE to control building of SVE support
> into the kernel, and adds a stub predicate system_supports_sve() to
> control conditional compilation and runtime SVE support.
> 
> system_supports_sve() just returns false for now: it will be
> replaced with a non-trivial implementation in a later patch, once
> SVE support is complete enough to be enabled safely.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
