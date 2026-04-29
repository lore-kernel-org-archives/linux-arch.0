Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE0392807;
	Wed, 29 Apr 2026 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494567; cv=none; b=AQxfG88O70g+lNJgjHCq4PBDJVh/8q79+QHn0n5acmalqdFdAPsw0YO3dMEUV5e7V4kN2Qm76ssRINhc8toN3DZj5lCfXY+qmvpIrO4FB+ds4Rr8FNN9bWuP3+68bmtAOfH41I2y2+MYjFDH0VtRleW+jRGz8g3Lu1RHAej3zTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494567; c=relaxed/simple;
	bh=HH+KQvkzBNqRGxUjoFpvNFOMjZKpfO8LsdVYeYm3uOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQXJCoTsW2NgU99qihW3YCNeep9+TYPAO7OWc+3wGJUjADvfog/R2kHkW9JUuK9ZZRTh+evD53+WN22S2HltQH8kT1iMQ+f0f99Kjl/QnIXOgl6JHtK6sJPITLWqphdJZi01GpAv4U5g3Jc7g5Z+HOU1vySADiWfZqiF9Ic2Mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9lGsPgL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9lGsPgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A652EC19425;
	Wed, 29 Apr 2026 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777494567;
	bh=HH+KQvkzBNqRGxUjoFpvNFOMjZKpfO8LsdVYeYm3uOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9lGsPgLSrCXmU8d7mjNx7wf9uQT/2BqyvHTxM8svYyt0+Sdpahq3xIQrTXuOpAQm
	 MjtsSt23NnFUOfCiUxFdMKs9qyTCDiicq85kS+uKugrdpzaGEEGPdot6VlvXi7VBHC
	 ryoHkioB1F73N0Bz0YH81b+yq5l/QQuopEsvVuzZJsT5VopbPlgFo9WaDYv/wfW1w4
	 gkfCoeLDB45K4cEmDmJ2+S1KljBMAw2EOREBSR3+0EB15/nEku3u1MSRZaD14wVTxO
	 qjX0aq39gOMn5ZGBIpdp2mIFLEZaRJxC1V7i7L+a1pNtonkz0K79MjQhwpi7xUY6Bn
	 vgB4tOd/rDt6g==
Date: Wed, 29 Apr 2026 13:29:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	cp0613@linux.alibaba.com
Subject: Re: [PATCH v5 2/3] bitops: Define generic __bitrev8/16/32 for reuse
Message-ID: <20260429202922.GA3575295@ax162>
References: <20260421130752.607500-1-ruanjinjie@huawei.com>
 <20260421130752.607500-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421130752.607500-3-ruanjinjie@huawei.com>

Hi Jinjie,

On Tue, Apr 21, 2026 at 09:07:51PM +0800, Jinjie Ruan wrote:
> Define generic __bitrev8/16/32 using the implementation
> in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
> such as RISCV.
> 
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++++++++++++++
>  include/linux/bitrev.h                | 20 ++++----------------
>  2 files changed, 29 insertions(+), 16 deletions(-)
>  create mode 100644 include/asm-generic/bitops/__bitrev.h
> 
> diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
> new file mode 100644
> index 000000000000..f06af929678d
> --- /dev/null
> +++ b/include/asm-generic/bitops/__bitrev.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
> +#define _ASM_GENERIC_BITOPS___BITREV_H_
> +
> +#ifdef CONFIG_GENERIC_BITREVERSE

The dependencies of this symbol seem insufficient, as I can trigger a
build failure on next-20260429 like so:

  $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper tinyconfig fs/select.o
  In file included from include/linux/crc32.h:6,
                   from include/linux/etherdevice.h:23,
                   from include/linux/if_vlan.h:11,
                   from include/linux/filter.h:21,
                   from include/net/xdp.h:10,
                   from include/net/busy_poll.h:19,
                   from fs/select.c:33:
  include/linux/etherdevice.h: In function 'eth_hw_addr_crc':
  include/linux/bitrev.h:16:20: error: implicit declaration of function 'generic___bitrev32' [-Wimplicit-function-declaration]
     16 | #define __bitrev32 generic___bitrev32
        |                    ^~~~~~~~~~~~~~~~~~
  include/linux/bitrev.h:67:9: note: in expansion of macro '__bitrev32'
     67 |         __bitrev32(__x);                                \
        |         ^~~~~~~~~~
  include/linux/crc32.h:107:36: note: in expansion of macro 'bitrev32'
    107 | #define ether_crc(length, data)    bitrev32(crc32_le(~0, data, length))
        |                                    ^~~~~~~~
  include/linux/etherdevice.h:292:16: note: in expansion of macro 'ether_crc'
    292 |         return ether_crc(ETH_ALEN, ha->addr);
        |                ^~~~~~~~~
  make[5]: *** [scripts/Makefile.build:289: fs/select.o] Error 1
  ...

  $ scripts/config -s BITREVERSE
  undef

  $ rg BITREVERSE .config

> +#include <asm/types.h>
> +
> +extern u8 const byte_rev_table[256];
> +static __always_inline __attribute_const__ u8 generic___bitrev8(u8 byte)
> +{
> +	return byte_rev_table[byte];
> +}
> +
> +static __always_inline __attribute_const__ u16 generic___bitrev16(u16 x)
> +{
> +	return (generic___bitrev8(x & 0xff) << 8) | generic___bitrev8(x >> 8);
> +}
> +
> +static __always_inline __attribute_const__ u32 generic___bitrev32(u32 x)
> +{
> +	return (generic___bitrev16(x & 0xffff) << 16) | generic___bitrev16(x >> 16);
> +}
> +#endif /* CONFIG_GENERIC_BITREVERSE */
> +
> +#endif /* _ASM_GENERIC_BITOPS___BITREV_H_ */
> diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
> index d35b8ec1c485..11620a70e776 100644
> --- a/include/linux/bitrev.h
> +++ b/include/linux/bitrev.h
> @@ -12,22 +12,10 @@
>  #define __bitrev8 __arch_bitrev8
>  
>  #else
> -extern u8 const byte_rev_table[256];
> -static inline u8 __bitrev8(u8 byte)
> -{
> -	return byte_rev_table[byte];
> -}
> -
> -static inline u16 __bitrev16(u16 x)
> -{
> -	return (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8);
> -}
> -
> -static inline u32 __bitrev32(u32 x)
> -{
> -	return (__bitrev16(x & 0xffff) << 16) | __bitrev16(x >> 16);
> -}
> -
> +#include <asm-generic/bitops/__bitrev.h>
> +#define __bitrev32 generic___bitrev32
> +#define __bitrev16 generic___bitrev16
> +#define __bitrev8 generic___bitrev8
>  #endif /* CONFIG_HAVE_ARCH_BITREVERSE */
>  
>  #define __bitrev8x4(x)	(__bitrev32(swab32(x)))
> -- 
> 2.34.1
> 

-- 
Cheers,
Nathan
