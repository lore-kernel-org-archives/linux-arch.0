Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F63438B3;
	Tue,  9 Jun 2026 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969137; cv=none; b=hg3AArE9J1bkiTEynHCUg1NTnKA2L/8X9hOXCvdAIA27F8lTUdDNM644H5Saqil1Q3wknT3hHKG6hk7knj1TLlFbTXNb5JHWp4iZ+cYZeywAPF5mVELBKbkCcdx9fMjmMLdp+T0BjWFXwz+Cf1EmlHWi7MK/trphdArtpAXIeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969137; c=relaxed/simple;
	bh=QGP14ChqOqWDARMufemqIhiBCcuUsJDAgQPOhMUCTcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ay+J8gpvRSRK9itd7n5GaXdSXZGpqqXWmhBNwDTvPaFqOpvx0Fx5d3Z3hK1wwfnsAWhlfCc16JbNzeaLC4bmQTJLuC7MVsPnVME1ZDy0XenXMKXF05Dqy2q7yXaCrBjlh68AUNPFNXAjytVrjaJfUw1H/jyOaKWtTczfVjRc2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mTn7KZe/; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mTn7KZe/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HO6DGfU3xacey1W43Ld+NtfEtj2hV6hCNfH5uDNJXJE=;
	b=mTn7KZe//jeJvtyz+0rJ7TaeRaHON4eHxFTaPps68SscPn+PRPgy9c63srUkzdwf/VJW4yr0q
	CK1avzhCuJHPDW+3L+ENfGjx7SZPrnzlMC9zN/z/gSMRwyF95vTFOLzwQT6f7nBepFzGtlQSAJp
	NvRSOj+rAodzIQE9UZhwc84=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gZBFB0jLgz1prwj;
	Tue,  9 Jun 2026 09:30:54 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB0B40561;
	Tue,  9 Jun 2026 09:38:50 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 09:38:48 +0800
Message-ID: <2bd07ecf-9f7f-4c47-b5d8-0f17b72bc56d@huawei.com>
Date: Tue, 9 Jun 2026 09:38:48 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
To: Yury Norov <ynorov@nvidia.com>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, Eric Biggers
	<ebiggers@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC: David Laight <david.laight.linux@gmail.com>
References: <20260506175207.110893-1-ynorov@nvidia.com>
 <20260506175207.110893-5-ynorov@nvidia.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260506175207.110893-5-ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 5/7/2026 1:52 AM, Yury Norov wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
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
> Select HAVE_ARCH_BITREVERSE as well as GENERIC_BITREVERSE,
> and provide <asm/bitrev.h> to utilize these instructions when
> the Zbkb extension is available at runtime via the alternatives
> mechanism.
> 
> [Yury: select the options conditionally on BITREVERSE]
> 
> Link: https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  arch/riscv/Kconfig              |  2 ++
>  arch/riscv/include/asm/bitrev.h | 51 +++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 arch/riscv/include/asm/bitrev.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d235396c4514..a708583f785d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -104,6 +104,7 @@ config RISCV
>  	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
>  	select GENERIC_ARCH_TOPOLOGY
>  	select GENERIC_ATOMIC64 if !64BIT
> +	select GENERIC_BITREVERSE if HAVE_ARCH_BITREVERSE

Maybe 'select GENERIC_BITREVERSE if BITREVERSE' ?

>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_CPU_DEVICES
>  	select GENERIC_CPU_VULNERABILITIES
> @@ -128,6 +129,7 @@ config RISCV
>  	select HAS_IOPORT if MMU
>  	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_BITREVERSE if RISCV_ISA_ZBKB && BITREVERSE
>  	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
>  	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
>  	select HAVE_ARCH_JUMP_LABEL
> diff --git a/arch/riscv/include/asm/bitrev.h b/arch/riscv/include/asm/bitrev.h
> new file mode 100644
> index 000000000000..4b9b8d34cc3b
> --- /dev/null
> +++ b/arch/riscv/include/asm/bitrev.h
> @@ -0,0 +1,51 @@
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
> +	unsigned long result;
> +
> +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
> +		return generic___bitrev32(x);
> +
> +	asm volatile(
> +		".option push\n"
> +		".option arch,+zbkb\n"
> +		"rev8 %0, %1\n"
> +		"brev8 %0, %0\n"
> +		".option pop"
> +		: "=r" (result) : "r" ((long)x)
> +	);
> +
> +	return result >> (__riscv_xlen - 32);
> +}
> +
> +static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
> +{
> +	return __arch_bitrev32(x) >> 16;
> +}
> +
> +static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
> +{
> +	unsigned long result;
> +
> +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
> +		return generic___bitrev8(x);
> +
> +	asm volatile(
> +		".option push\n"
> +		".option arch,+zbkb\n"
> +		"brev8 %0, %1\n"
> +		".option pop"
> +		: "=r" (result) : "r" ((long)x)
> +	);
> +
> +	return result;
> +}
> +#endif

