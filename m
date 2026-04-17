Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843525A645
	for <linux-arch@vger.kernel.org>; Fri, 17 Apr 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431861; cv=none; b=ieHwdlqIIPH8rjZPpkSEUvw1utDhr/zS1zV0m21dafRft211OYof7CVxCE10LRS8dq/6IjfK7cPKqk1fFq+4xs0biFVt0PoI32aOMsVAidSS9J4RM210yogkPsAZwOEVl2a7dhCM6gXnpP6tSyJnpRHMRliQWPNZ+GfemoetrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431861; c=relaxed/simple;
	bh=4zifSvUnHZ/HKH6akKObswJKFAcf7nDWlR2trRYpZ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9J0/396r0yPoDV+vXdPTjQdtZdOVL7+anrxT7AKyTKJscdz8YdzksSDDfdMzTMjvjDB3gFx98lP7zbL4QaxxibeuHWPmlhpTeukydZbRtudcqQzQphCy8QEBpMXjNInOR3WnFtp1lnltaAHbqoiABfEMtw2IbjDGKuulzQAwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryJBF5vl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryJBF5vl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b980785a0bfso105464566b.3
        for <linux-arch@vger.kernel.org>; Fri, 17 Apr 2026 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776431858; x=1777036658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UABl9nq8984zfp4fbqeJUZW99tYPErqX1nIpSgG/cso=;
        b=ryJBF5vlZJHdovYInRWg+r0C34aIS++Z0yijL7nrDuDRpohGxuhj78snsKprLG9FUC
         O/l4ipAZSGQboLQnlSNILEfJBy8rUAhbEQ6IhfDwlrty0oGDd95qXvNS9SDRjL3zq17b
         QqKN++s6ENZi8CYlC7dGkKn+Bbd1aRrxa63J11RDGQtr1f2MkjmMCvEZUrKMU5xu7Y2h
         NmUG8Z0fTuQit+VXIYNOCEsQQwpk7lGm7OAWQ6eER71Wd8pCaAsBDVAo9q8LIlOXq55J
         UJ25Kqnf6AbFI5LjNZtMXgfbBUxNYqsrLel/O8BwUpPjbvePUfyp/ayATk0UtXglnvpo
         2hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431858; x=1777036658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UABl9nq8984zfp4fbqeJUZW99tYPErqX1nIpSgG/cso=;
        b=IzpNTVpD06LE1F8xomWpoqkMHYzJ75aHN2FiooTEHFuTjzdqHhFWi+4lMCBAVjoy2k
         dMGjNrwYt02bEw4xHEjsAdSNqIQqf99IyRG3o8tkDt0edEi+Q604YkTur7kokhJhbi8s
         V7UibWru4L7+oyV5CNFh7SKQ+dvWHtfDhLZ3PTDMZrL7v88DE7gdLfBnR3tR0pmX7SE4
         62RAPCG3H7XXzerfKx0/lQXvFnFJQdMWInXRGvtszcLBshLEz6rPs59QRlTrVmqldpeB
         MR4Fjc3HoXttmsU2HJPsBnY2Vo5umtt7hl0s3jSfBENPrO1wOHDc/eh3Ynm/9xv/4xmo
         EM1w==
X-Forwarded-Encrypted: i=1; AFNElJ+fe1kUVX6hsuUf/CVbFmFHOMoIkiQqvyALhrLdi5F3IJh8i/m5/06E2GR3c29VkWtfD4/+DxTwWtbY@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwJiYOO+Db72QCLhUu2G7QAKhuybH4+Oqb8NrKTxxuFy17GsZ
	t+Gvbxk+AZsIHJ5PtmnHxRqcw7EhAmDmv5cpZEnKohxH1tMMJsGVPPI+
X-Gm-Gg: AeBDietK1Vo0gbm6LwY8RxZ31xdsddfCN13bx5QammetpzAmkzOSy8FDCJkhVBj8n7C
	oqSK5Oibya+63I6wfgqPjRmJK/GRMKWFzZx6qIq3KZF6mmN247lYHE7D2Y8LXZF14sz7eAWVDft
	iVLGYbHLRfRVYAC/G9pQLwKhjuL7A64mTMCWuSV8sXL52+l3K+xLN5IzvOiyZrCne9qeCiGiL5L
	lS9ovLnlOGK43U7j/FT14e66cGwd4nO+lJY6y/2FVpk7/CNfWwLALVRAvZaglNwuRzUpscN5HCu
	wdhNM97dRKscSUk9iQCKpTL/zDi8OaI1Mlnju918uX4pqJcPO12UYYL6ZkMzttoTA/VLZqHJSVh
	2CcFto2IrMeAjXENU48X5OohC+wRNrgfgYJyJV13Af7ojramhmIq/PX+/YOMnRDdBktMege98va
	0Gk2KmpN13enLZP/ijlQ3lCWQPUrFhpjt2pgIq81VYmMAJazct8DwR7M8W1aLFxYwxH2jsAdMVo
	+k=
X-Received: by 2002:a17:906:59a8:b0:b9d:c34f:2a2b with SMTP id a640c23a62f3a-ba41b3dffb6mr110834266b.40.1776431858275;
        Fri, 17 Apr 2026 06:17:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm4104912f8f.32.2026.04.17.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:17:37 -0700 (PDT)
Date: Fri, 17 Apr 2026 14:17:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
 <arnd@arndb.de>, <akpm@linux-foundation.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <nathan@kernel.org>
Subject: Re: [PATCH v3 2/2] arch/riscv: Add bitrev.h file to support rev8
 and brev8
Message-ID: <20260417141736.33a993e7@pumpkin>
In-Reply-To: <20260417093102.3812978-3-ruanjinjie@huawei.com>
References: <20260417093102.3812978-1-ruanjinjie@huawei.com>
	<20260417093102.3812978-3-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 17:31:02 +0800
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
> Link: https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/bitrev.h | 55 +++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
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
> index 000000000000..eef263cc6655
> --- /dev/null
> +++ b/arch/riscv/include/asm/bitrev.h
> @@ -0,0 +1,55 @@
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
> +	unsigned long result = (unsigned long)x;

Just:
	unsigned long result;

> +
> +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
> +		return generic___bitrev32(x);
> +
> +	asm volatile(
> +		".option push\n"
> +		".option arch,+zbkb\n"
> +		"rev8 %0, %0\n"

Replace the source with %1

> +		"brev8 %0, %0\n"
> +		".option pop"
> +		: "+r" (result)

then:
		: "=r" (result) : "r" ((long)x)
it is likely to save a register-register move

> +	);
> +
> +#if __riscv_xlen == 64
> +	return (u32)(result >> 32);
> +#else
> +	return (u32)result;
> +#endif

There is no need to either cast, and the kernel style doesn't need them.
(Filling code with casts that match the implicit conversions just makes
it harder to find/check the ones that are absolutely necessary and actually
change the behaviour.)
You could just do:
	return result >> (__riscv_xlen - 32);

> +}
> +
> +static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 16;

Kill the cast.

> +}
> +
> +static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
> +{
> +	unsigned long result = (unsigned long)x;
> +
> +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
> +		return generic___bitrev8(x);
> +
> +	asm volatile(
> +		".option push\n"
> +		".option arch,+zbkb\n"
> +		"brev8 %0, %0\n"
> +		".option pop"
> +		: "+r" (result)

Use "=r" (result) : "r" ((long)x) again

> +	);
> +
> +	return (u8)result;

Kill another cast.

> +}
> +#endif

