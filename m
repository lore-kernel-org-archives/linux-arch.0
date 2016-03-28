From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Mon, 28 Mar 2016 08:51:06 +0200
Message-ID: <20160328065106.GA12154@ravnborg.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com>
 <56F75490.9010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:42649 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbcC1GvO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2016 02:51:14 -0400
Content-Disposition: inline
In-Reply-To: <56F75490.9010608@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

> diff --git a/include/asm-generic/bitops/arch_parity.h b/include/asm-generic/bitops/arch_parity.h
> new file mode 100644
> index 0000000..cddc555
> --- /dev/null
> +++ b/include/asm-generic/bitops/arch_parity.h
> @@ -0,0 +1,39 @@
> +#ifndef _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
> +#define _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
> +
> +#include <asm/types.h>
> +
> +/*
> + * Refrence to 'https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel'.
> + */
> +
> +static inline unsigned int __arch_parity4(unsigned int w)
> +{
> +	w &= 0xf;
> +	return (0x6996 >> w) & 1;
> +}
> +
> +static inline unsigned int __arch_parity8(unsigned int w)
> +{
> +	w ^= w >> 4;
> +	return __arch_parity4(w);
> +}
> +
> +static inline unsigned int __arch_parity16(unsigned int w)
> +{
> +	w ^= w >> 8;
> +	return __arch_parity8(w);
> +}
> +
> +static inline unsigned int __arch_parity32(unsigned int w)
> +{
> +	w ^= w >> 16;
> +	return __arch_parity16(w);
> +}
> +
> +static inline unsigned int __arch_parity64(__u64 w)
> +{
> +	return __arch_parity32((unsigned int)(w >> 32) ^ (unsigned int)w);
> +}
Defining these as static inlines in asm-generic prevent an architecture
from selecting between a more optimal asm version or the generic version
at run-time.
sparc would benefit from this as only some sparc chips supports popc.
See how this is done for hweight*

	Sam
