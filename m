From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 03/31] arm64: Exception handling
Date: Wed, 15 Aug 2012 13:03:47 +0000
Message-ID: <201208151303.47743.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63916 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab2HONDv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 09:03:51 -0400
In-Reply-To: <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +#ifdef CONFIG_AARCH32_EMULATION
> +#define compat_thumb_mode(regs) \
> +	(((regs)->pstate & COMPAT_PSR_T_BIT))
> +#else
> +#define compat_thumb_mode(regs) (0)
> +#endif

The symbol we use on other platforms is CONFIG_COMPAT. I don't think you
need to have a separate CONFIG_AARCH32_EMULATION

> +void __bad_xchg(volatile void *ptr, int size)
> +{
> +	printk("xchg: bad data size: pc 0x%p, ptr 0x%p, size %d\n",
> +		__builtin_return_address(0), ptr, size);
> +	BUG();
> +}
> +EXPORT_SYMBOL(__bad_xchg);
> +

I think we're better off not defining this function. My guess is that
initially the idea on ARM was that it was meant as a BUILD_BUG_ON
replacement, but the someone added this function. And you copied it.

Microblaze has the same declaration, but (correctly) misses the
definition, which produces a much more helpful link failure than
a run-time BUG(). Using BUILD_BUG_ON would be even better.

	Arnd
