Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BD26B2D3;
	Tue,  9 Jun 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970025; cv=none; b=o6KOvNzo75JlXAnUqykSUdi3wfWpDfA9sYk4+YhBNstYyUseNEJf7afGmCAwDyBSSCE7QKlgCM6bHbaal/3+CsPfq3xbMe69DYLSQ4CzIBnQ3EvXaCZc5Mc0v1Q7L2tC0COEd6SdJmv8bz/qKNlSC6T2U44li5+Sg2He2BLox00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970025; c=relaxed/simple;
	bh=1YR1TlFy8rdpDyUa01leLBgZiwvXHIjqEhqXwyvuYL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p9RAarX3DGD1aSDCZ32oVr14qKv2WKw7zQQmmUEnOZU2/aErppnpgXiu4bvuL3VqjUJTobnFI1JN/nkX63Bqt5svXVtd+UAWENVy1k+qyUDc8UokXzit+4Vv+AV2cHTzl49jaFBbzEiEGVkF0Q0un8YaVKXDRUKLd3AB42FcC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ef/MIZuX; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ef/MIZuX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mka3w3BI1l7jdb6CzO1A3gkyAdvjTIHuJhEcsHosDQU=;
	b=ef/MIZuXfPFSnQJxprUwGgoFDlM9Q39furpMEEbHtDw5Ed5jedLc4ab+G0UzS5U78IeAv6Io5
	kDWKLLy79eMr5d9b/uTMyScsJqIzQIss5/KqJPxBBaHKEML39BRunvvDZWzxQXIBT4LbHBGzl3R
	pkGyhihP7ggRTd3+ir7S0Z0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gZBZ103V5zcZyh;
	Tue,  9 Jun 2026 09:45:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E32040576;
	Tue,  9 Jun 2026 09:53:38 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 09:53:36 +0800
Message-ID: <81d1ae23-8d18-4dff-a5c9-1824980b08ef@huawei.com>
Date: Tue, 9 Jun 2026 09:53:36 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] lib/bitrev: Introduce GENERIC_BITREVERSE
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
References: <20260506175207.110893-1-ynorov@nvidia.com>
 <20260506175207.110893-3-ynorov@nvidia.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260506175207.110893-3-ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 5/7/2026 1:52 AM, Yury Norov wrote:
> The generic bit reversal implementation is controlled by
> !HAVE_ARCH_BITREVERSE. This makes it difficult for architectures to
> provide a hardware-accelerated implementation while being able to
> fall back to the generic version if needed.
> 
> This patch adds GENERIC_BITREVERSE, so bitreverse API is controlled by
> BITREVERSE, GENERIC_BITREVERSE and HAVE_ARCH_BITREVERSE options. The
> relationship between them is described as follows:
> 
>  - BITREVERSE is selected by user code; it's required to generate the API;
>  - Architectures may select HAVE_ARCH_BITREVERSE and provide an arch
>    implementation in arch/$(ARCH)/include/asm/bitrev.h.
>  - if HAVE_ARCH_BITREVERSE isn't set, BITREVERSE selects GENERIC_BITREVERSE;
>  - if GENERIC_BITREVERSE is set and HAVE_ARCH_BITREVERSE is not, the kernel
>    provides generic implementation only, and wires bitrevXX() to it.
>  - if HAVE_ARCH_BITREVERSE is set and GENERIC_BITREVERSE is not, the arch
>    code provides __arch_bitrevXX(), and it is wired to bitrevXX();
>  - if both GENERIC_BITREVERSE and HAVE_ARCH_BITREVERSE are selected, the kernel
>    generates generic___bitrev(), but wires bitrev() to the __arch_bitrev().
> 
> The last option allows architectures to use generic___bitrev() as a
> fallback option.
> 
> Drivers and core code should never select GENERIC_BITREVERSE or
> HAVE_ARCH_BITREVERSE explicitly.
> 
> Architectures that require generic bitreverse API as a fallback should
> explicitly enable GENERIC_BITREVERSE together with HAVE_ARCH_BITREVERSE.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  lib/Kconfig  | 12 ++++++++++++
>  lib/Makefile |  2 +-
>  lib/bitrev.c |  3 ---
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index d8e7e89ae320..a33988adfaa3 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -54,6 +54,7 @@ config PACKING_KUNIT_TEST
>  
>  config BITREVERSE
>  	tristate
> +	select GENERIC_BITREVERSE if !HAVE_ARCH_BITREVERSE
>  
>  config HAVE_ARCH_BITREVERSE
>  	bool
> @@ -63,6 +64,17 @@ config HAVE_ARCH_BITREVERSE
>  	  This option enables the use of hardware bit-reversal instructions on
>  	  architectures which support such operations.
>  
> +config GENERIC_BITREVERSE
> +	tristate
> +	depends on BITREVERSE
> +	help
> +	  Generic bit reversal implementation. Drivers should never enable
> +	  it explicitly. Instead, enable BITREVERSE.


The later riscv implementation force GENERIC_BITREVERSE even when
HAVE_ARCH_BITREVERSE=y but triggers a Kconfig unmet direct dependency
warning as below:

warning: (RISCV) selects GENERIC_BITREVERSE which has unmet direct
dependencies (BITREVERSE)

This happens because select ignores depends on clauses and can force a
tristate symbol to y even when its dependency BITREVERSE is only =m. The
warning is a symptom of an invalid dependency chain.

Link:
https://lore.kernel.org/all/20260506214943.1AAE8C2BCB0@smtp.kernel.org/

> +
> +	  Architectures may want to select it as a fall-back option for
> +	  HAVE_ARCH_BITREVERSE, when the hardware-accelerated bit reverse
> +	  instruction set is optional, like RISC-V ZBKB extension.
> +
>  config ARCH_HAS_STRNCPY_FROM_USER
>  	bool
>  
> diff --git a/lib/Makefile b/lib/Makefile
> index f33a24bf1c19..23e07d19d01c 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -145,7 +145,7 @@ obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
>  obj-$(CONFIG_LIST_HARDENED) += list_debug.o
>  obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
>  
> -obj-$(CONFIG_BITREVERSE) += bitrev.o
> +obj-$(CONFIG_GENERIC_BITREVERSE) += bitrev.o
>  obj-$(CONFIG_LINEAR_RANGES) += linear_ranges.o
>  obj-$(CONFIG_PACKING)	+= packing.o
>  obj-$(CONFIG_PACKING_KUNIT_TEST) += packing_test.o
> diff --git a/lib/bitrev.c b/lib/bitrev.c
> index 81b56e0a7f32..05088231f31f 100644
> --- a/lib/bitrev.c
> +++ b/lib/bitrev.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#ifndef CONFIG_HAVE_ARCH_BITREVERSE
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/bitrev.h>
> @@ -43,5 +42,3 @@ const u8 byte_rev_table[256] = {
>  	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
>  };
>  EXPORT_SYMBOL_GPL(byte_rev_table);
> -
> -#endif /* CONFIG_HAVE_ARCH_BITREVERSE */

