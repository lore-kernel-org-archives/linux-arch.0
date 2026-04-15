Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BA318ED6
	for <linux-arch@vger.kernel.org>; Wed, 15 Apr 2026 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252778; cv=none; b=RuvI8xOjZ0wJ+j8jnrlnQAfW9Lc/f0i6+4wbQ+vPmOQ/aR1xZHTd/fG+wfj+l3F7K/DC6bvXAsjXeeGhBDnfhKg3kf6e6rpXmfKoLKvNDxObE6ZRwuTVhlOuF3gXJe7zQOKFVRRhiy4BZPGYrfvJVmtiHZhYQesBHuaQwezeXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252778; c=relaxed/simple;
	bh=gR41Pja/K6i9C53vPaLlSLrKK2cEtWKsCTH/bEJcXqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6P49KM35P2f9Mk8K6f4kip4vxewoaUg4cAlVnNmUXan6EsMnkTVOo+Ja0dQKh6lkMjHmFQQTXd5C02QZ9tksZCuodC9C8asCdDPI2Pu/MDYn+vrumGALw+SOG6PNdT58d8EGOvB+uyEeVC+XY3AK4TdjE0o5zEzE9PuZ794yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhpRK7eo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhpRK7eo"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d74086e5bso2572955f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 15 Apr 2026 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252775; x=1776857575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2FCUrZRaW+mZzvA8FAeIT0/MW/6T/TDKPdP+BgE9zU=;
        b=lhpRK7eo5WnGzcitBuuWB3DYG+NIzVP3cLUDy+5EG0ZmBVUY2oUfDbaemslF09+Bpg
         1YIzthqzBnk3+EthgXR3dNx2RUZVU5q+amG+pteQOay6e0qp+j69ZVh4pG/edy/AfTS2
         SDtDMXBNq56nbH5+XTnb4cCIhtxbvx+ZgOgi4c8XDpSbGNwOBctoUJYfHiC958nkmzoj
         CcJtb890r9tlcjGFEDEqjNDEjYh4tHqtmjB2f9tZ3xgUovZFX0qiTFhHHSTD2ct6yJYh
         PlE88eayMn3PQyWVot1UIlKiTh+3OEZ3YwELN8KJ5yhl2r87l714yI5Xzx1IeujbDkt/
         AJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252775; x=1776857575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2FCUrZRaW+mZzvA8FAeIT0/MW/6T/TDKPdP+BgE9zU=;
        b=CVrCcFbfeV32IKuvr/VtPlw6tTIeYz97CssCItuzsOtLVPEYdOVztnMaZve/3kl+rq
         1+ImPfgZ6Q5xIM/oEafzobOC+BHUe2FwcmCQolOXWoWe64qANQtoiPfq0IAKyHVlUb81
         DRE3fwpLe7qElv2EAKFjufWpYGPZR0RoYzo/92Y0MXxT8RYMh1jch+fucBTPNYRtFkpx
         oaqSzx2WqlVzRNQyn+wJO+2B56/iwCZ/PxC/5LTMSer5oiMjWY9qeeaMgaONYY7S7+O6
         l9AvhfxWid7knaAzG+m86/qD7mOROKYK7S3/hE7BxFVduZQhpevZasmC0qe8KI91EaNZ
         M0Xw==
X-Forwarded-Encrypted: i=1; AFNElJ94SGiZFzTg7FLEyScspSIWW65YIyoETtyvsWePDJEMb/Rph17Kaif7RINTeXl0jBXHHyIKxMGFuTdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOqMKbM1JOoPCslhMccBH/C8ayDM/KIxG7GfFe9NTdtDNH86q
	nGkB7z1CyNxEhVOheBTok4V9GH1DGI8w0zqTvqfKnxF93LuPQ7RqsvTM
X-Gm-Gg: AeBDietQJ2ObZLV9KDVvkskT8wzcB8CTEhOjzeuC1ic17j9OsveKugxub3eCaqax+rm
	SBihed71SE6W4kO8F9h8ysW4ea03o0jASQX3YWZ3vQf4MjI6rTDtxlgxGd3Hm9VEXwuvm+4q50H
	tFW5tX0d0ljrZjKp3X4K6jDTC1oT/s/hKFovHFiOumNEncNQgsgd9HvRgS9rnxkk5d/Zddn1+gh
	1J/lhSeSycu/nACWin7hsaIQ3wbQrJT9ErIqkHVWENYjFWjCmwGYjutxHY5zihV3RNb/Ru/eD43
	8aE7cPZBWQBoNcufgvMDwP+mh3M/1fShIGCqYSaqwPhF5nOV+x32BgdfFPvlOXLpc4CEK2bNwLg
	tZL1dh6WCkynvLOgWl9+D1rww7ZyNidd1iwzq4dL8HQ1BrOOUoUMSWhNq/Ar2txc+ViaHEyDiSq
	hgywsHLPWHXvsdBXBcQkgSqa80kOtTaDKPEbd4G3YmiftBPVVrxObR9o/ncwHVVVkQ
X-Received: by 2002:a05:6000:240e:b0:43e:aefa:db84 with SMTP id ffacd0b85a97d-43eaefadc12mr935013f8f.34.1776252775085;
        Wed, 15 Apr 2026 04:32:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e00b3sm4261659f8f.27.2026.04.15.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:32:54 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:32:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
 <arnd@arndb.de>, <cp0613@linux.alibaba.com>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arch/riscv: Add bitrev.h file to support rev8
 and brev8
Message-ID: <20260415123252.017bd5e2@pumpkin>
In-Reply-To: <20260415093827.2776328-3-ruanjinjie@huawei.com>
References: <20260415093827.2776328-1-ruanjinjie@huawei.com>
	<20260415093827.2776328-3-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 17:38:27 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

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
> +
> +	asm volatile(
> +		".option push\n"
> +		".option arch,+zbkb\n"
> +		"rev8 %0, %0\n"

It would be better to pass (long)x in for the source.
Might save the compiler doing a register-register move.

> +		"brev8 %0, %0\n"
> +		".option pop"
> +		: "+r" (result)
> +	);
> +
> +	if (__riscv_xlen == 64)
> +		return (u32)(result >> 32);

Is that right?
ACAICT __riscv_xlen is 32 for 32bit builds and 64 otherwise.
(No idea why riscv has its own private constant for that.)
I'm guessing that 'brev' is bit-reverse (or each byte) and 'rev'
a byteswap, the '8' suffix rather implies it acts on 8 bytes
which makes is 64bit only.
So does 'rev8' even compile for 32bit.
You are also likely to get a warning on 32bit for 'result >> 32'.

> +
> +	return (u32)result;
> +}

I'm not sure is is a good idea inline that into its callers.
But I can't think of a way to get either the instructions or
a call patched in at the call site.

> +
> +static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 16;
> +}
> +
> +static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 24;

That seems excessive when it could just be a 'brev' instruction.

Oh, and none of the casts on the function call parameters or results
are needed - they are all implied.

	David


> +}
> +#endif

