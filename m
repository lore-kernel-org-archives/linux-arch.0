Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE473845B0;
	Thu, 16 Apr 2026 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381286; cv=none; b=mBqYSAdOyagWmofYEoy6y07a/3qNCXmC3aEyWmv4WndkiunrK5A92aLsjdeVO97VjEZ/iVmApfmA+sWz/suL//ml9kZeGZD8j2z8SMgM6A+LHfxzmdiyz9kaThquYRMsHegM2B7SakvjeGTTWIYRG2efmBOIQH7ah+7Rt6dkBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381286; c=relaxed/simple;
	bh=RhsfpYz074F1zePwsOPGjbA5V2kooOyckVK4f6GXIk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA22zkvJN3Gqa99MJXl1thpeDrpIQWjVVzsNMXPkaF676IGQuef2ZGWcsjXN7pz71BfbhWssZFsfbOfl9paBEgcCJzBJE5H43TgwzCLWrYcuuaw7mMZsCM+dA3BykqzseL0nAw34o3kddtuZaZppPV2AYqrQ6SsPf4xtJSDO4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTMIg5lc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTMIg5lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EA7C2BCAF;
	Thu, 16 Apr 2026 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776381286;
	bh=RhsfpYz074F1zePwsOPGjbA5V2kooOyckVK4f6GXIk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTMIg5lc3fADC3RVjtb/nXqcZ9BcKgCzLhBR3tkx8LcPqe8Ad2YkIiSZAhMyphak0
	 eNk+m+KBWBde1BDwzsFNm2J8pe/CPA8qdHqCelvAHvwPlnIWSErK8xnx9A8UBoFKCi
	 qJ9trDIUsDxdC7HhK1Vn05v3RmIe7x8aWKetbM1mXT6xFuXIifk8qsFUS5cSnHe/jz
	 XNtMpOXtTIKmmKqqCKnksphbrE/uqkch1UYmQ7eDaQyO0yp8QmEzTWhw9uUowTpTL+
	 Y2lAz6mv8IhFAEioFlRSnBgwi6Tz16gpjzRCYetdHjoPfbod13MyX2BUg20EdDlMNY
	 dva47sy68HDDQ==
Date: Thu, 16 Apr 2026 16:14:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, yury.norov@gmail.com
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux@rasmusvillemoes.dk, arnd@arndb.de,
	cp0613@linux.alibaba.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
Message-ID: <20260416231441.GA12905@ax162>
References: <20260415093827.2776328-1-ruanjinjie@huawei.com>
 <20260415093827.2776328-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415093827.2776328-3-ruanjinjie@huawei.com>

On Wed, Apr 15, 2026 at 05:38:27PM +0800, Jinjie Ruan wrote:
> The RISC-V Bit-manipulation Extension for Cryptography (Zbkb) provides
> the 'brev8' instruction, which reverses the bits within each byte.
> Combined with the 'rev8' instruction (from Zbb or Zbkb), which reverses
> the byte order of a register, we can efficiently implement 16-bit,
> 32-bit, and (on RV64) 64-bit bit reversal.
> 
> This is significantly faster than the default software table-lookup
> implementation in lib/bitrev.c, as it replaces memory accesses and
> multiple arithmetic operations with just two or three hardware
> instructions.
> 
> Select HAVE_ARCH_BITREVERSE and provide <asm/bitrev.h> to utilize
> these instructions when the Zbkb extension is available at runtime
> via the alternatives mechanism.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/bitrev.h | 41 +++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 arch/riscv/include/asm/bitrev.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 90c531e6abf5..05f2b2166a83 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -128,6 +128,7 @@ config RISCV
>  	select HAS_IOPORT if MMU
>  	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_BITREVERSE if RISCV_ISA_ZBKB
>  	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
>  	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/bitrev.h b/arch/riscv/include/asm/bitrev.h
> new file mode 100644
> index 000000000000..9f205ac84796
> --- /dev/null
> +++ b/arch/riscv/include/asm/bitrev.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_BITREV_H
> +#define __ASM_BITREV_H
> +
> +#include <linux/types.h>
> +#include <asm/cpufeature-macros.h>
> +#include <asm/hwcap.h>
> +#include <asm-generic/bitops/__bitrev.h>
> +
> +static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
> +{
> +	unsigned long result = x;
> +
> +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
> +		return generic___bitrev32(x);

This breaks the build when CONFIG_HAVE_ARCH_BITREVERSE is set because
generic___bitrev32() ultimately calls generic___bitrev8(), which uses
byte_rev_table but that is only included in lib/bitrev.c when
CONFIG_HAVE_ARCH_BITREVERSE is not set. How was this tested? This seems
a pretty basic build problem that has showed up in a variety of
configurations (at least all the configurations that our CI tests).

  $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux- mrproper defconfig all
  ERROR: modpost: "byte_rev_table" [lib/zlib_deflate/zlib_deflate.ko] undefined!
  ERROR: modpost: "byte_rev_table" [drivers/net/ethernet/spacemit/k1_emac.ko] undefined!
  ERROR: modpost: "byte_rev_table" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] undefined!

  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/24529356842
  https://lore.kernel.org/177635154368.6552.7060101263009785041@8692ffc4d55e/

Yury, are you intending to send this series to Linus in the 7.1 merge
window? If not, it shouldn't be in -next at this point.

> +	asm volatile(
> +		".option push\n"
> +		".option arch,+zbkb\n"
> +		"rev8 %0, %0\n"
> +		"brev8 %0, %0\n"
> +		".option pop"
> +		: "+r" (result)
> +	);
> +
> +	if (__riscv_xlen == 64)
> +		return (u32)(result >> 32);
> +
> +	return (u32)result;
> +}
> +
> +static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 16;
> +}
> +
> +static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 24;
> +}
> +#endif
> -- 
> 2.34.1
> 
