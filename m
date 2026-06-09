Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F031AA87;
	Tue,  9 Jun 2026 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968389; cv=none; b=t5Uy10t3hVCeCU2Uqhp4sx7xmOhlivyeR/uXZfz6Q/C2k34xqeUd3mVdv/w/s//L1Rlyrw/jlU5P8B6TTbOHW+zWpCpX4wrX2LcTeZTxdLkSB/s0AKMntJAAUyclJJbyhzGluCVCoGcNAhCegOmgCRRilGRIXXdLvpFLdhWGJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968389; c=relaxed/simple;
	bh=pjMGdwmTqUOftIQ1xa957Y8AsuBUdyuqDb5CEAl7kO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rI87iaRVqg8Ojx8mW7EA8LfC7kfyBKABiXgj2papTC4HxKv+MDfrAnxgZAZUfeF+jLdq6najv4VoJ3iyycU/mjI7fLQVCH+v6rQJLWjSSCrv4ANRmVt1lSqp+VRKgWEvls3lCfkf7lKwAd1OZ8PVU7wrcPPE3e8WRDdn/m8b0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uNZ/lD6x; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uNZ/lD6x"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RAKmwwhQRi36bLXMT3L71Qr2hQy8TZ9Rjt+61CaC2Gc=;
	b=uNZ/lD6xy4gcozLt8EGdm86gc2KXSUYpmpBnbEG/Wj4pAwbQebGa91QS4sON22E0vNLX4o3RZ
	VFAaNbVYp6UHRPV7Lf4J321CGuVPFuXmROsAk5ExmhWBOiCr7mqOwqmdt2MQgVlO0lL2HSSF4bq
	ZNl9ciP7EFyzgHFlsfEocLk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gZ9ys5pyCz1cyPW;
	Tue,  9 Jun 2026 09:18:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 08FBF40562;
	Tue,  9 Jun 2026 09:26:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 09:26:20 +0800
Message-ID: <08bcdf6c-62e1-46d8-af83-4d5e74fff956@huawei.com>
Date: Tue, 9 Jun 2026 09:26:20 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arch: select HAVE_ARCH_BITREVERSE conditionally on
 BITREVERSE
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
 <20260506175207.110893-2-ynorov@nvidia.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260506175207.110893-2-ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 5/7/2026 1:52 AM, Yury Norov wrote:
> Architectures may have bit reversal instructions, but if the API not
> needed, the corresponding option should not be selected because it may
> lead to generating the unneeded code.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  arch/arm/Kconfig       | 2 +-
>  arch/arm64/Kconfig     | 2 +-
>  arch/loongarch/Kconfig | 2 +-
>  arch/mips/Kconfig      | 2 +-
>  lib/Kconfig            | 1 +
>  5 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 71fc5dd4123f..0e963e54fe06 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -83,7 +83,7 @@ config ARM
>  	select HARDIRQS_SW_RESEND
>  	select HAS_IOPORT
>  	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
> -	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> +	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6 && BITREVERSE

I think there is a semantic confusion:

HAVE_ARCH_BITREVERSE indicates that the architecture itself has an
efficient bit‑reverse implementation (e.g., the RBIT instruction on
ARMv7). It is a hardware capability declaration and should not depend on
a higher‑level feature option like BITREVERSE.

>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && (!PREEMPT_RT || !SMP)
>  	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe60738e5943..f5bb62c2ba9c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -150,7 +150,7 @@ config ARM64
>  	select HAVE_ACPI_APEI if (ACPI && EFI)
>  	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
> -	select HAVE_ARCH_BITREVERSE
> +	select HAVE_ARCH_BITREVERSE if BITREVERSE

[..]

>  	bool
>  	default n
> +	depends on BITREVERSE
>  	help
>  	  This option enables the use of hardware bit-reversal instructions on
>  	  architectures which support such operations.

