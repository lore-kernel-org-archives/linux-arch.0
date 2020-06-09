Return-Path: <SRS0=6fqV=7W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgFIKCH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 06:02:07 -0400
Date: Tue, 9 Jun 2020 11:02:03 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Message-ID: <20200609100202.GB25362@willie-the-truck>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20200609100203.IfHKuz-jM5YnK4D1qFJUaZoIp7ffdRG8W1lK4JeOyFU@z>

On Wed, May 27, 2020 at 10:17:37PM +0100, Dave Martin wrote:
> Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
> 5.0 for arm64.

[...]

> +If the arguments are invalid,
> +and in particular if
> +.I arg2
> +contains set bits that are unrecognized
> +or that correspond to a key not available on this platform,
> +the call fails with error
> +.BR EINVAL .
> +.IP
> +.B Warning:
> +Because the compiler or run-time environment
> +may be using some or all of the keys,
> +a successful
> +.IP
> +For more information, see the kernel source file
> +.I Documentation/arm64/pointer\-authentication.rst
> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> +(or
> +.I Documentation/arm64/pointer\-authentication.txt
> +before Linux 5.3).
> +.B PR_PAC_RESET_KEYS
> +may crash the calling process.

I might be misreading this, but this looks like the kernel reference appears
mid-sentence. Regardless, I think we should drop the kernel doc reference,
as I mentioned on the SVE patches.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
