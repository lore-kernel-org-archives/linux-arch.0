Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B23B31AA83;
	Wed, 11 Feb 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825276; cv=none; b=przGpAKW5gPv0XxL6KuWZxXkQYuC8fMhNtaEFIPj9BQ765ElJXJtGVyrjIOY+D/cU+VCR58+tkY/hxRC68CbyKhuVgvT/ztQqELsfHMQfsgWhrN+5JW2P9jnKVWfVjyY3KsyHErYOVpkJsPsVCKdr03jrN68sxyFZnTVDkpfPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825276; c=relaxed/simple;
	bh=ycFotHEW/fi/WroyOipF6qRF/y98s9seCh6iBR1U6PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVsMfqI2jwK43JZeKNyp/QFBWSJEcq4BcMDKfnrFQgzVTYMrGbyVjJEWphk76PGq/kIvmZFccvlTXywU5MGL1Lo42ZIFC7WpNuEU8ZIm7r9stN8n9mLefiRPBv8mj5wTQ+Q3d95osSB413yzblWI9HzCA8HEi8CHhmL9OpD1tJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA07339;
	Wed, 11 Feb 2026 07:54:28 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC3FB3F632;
	Wed, 11 Feb 2026 07:54:30 -0800 (PST)
Date: Wed, 11 Feb 2026 15:54:27 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 02/12] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Message-ID: <aYymMze6Vchxe6jK@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-3-ankur.a.arora@oracle.com>

On Sun, Feb 08, 2026 at 06:31:43PM -0800, Ankur Arora wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93173f0a09c7..239fdca8e2cf 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -22,6 +22,7 @@ config ARM64
>  	select ARCH_HAS_CACHE_LINE_SIZE
>  	select ARCH_HAS_CC_PLATFORM
>  	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> +	select ARCH_HAS_CPU_RELAX

AFAICT, ARCH_HAS_CPU_RELAX is only defined for x86. You can't just
select it here. Either make the definition global somewhere or add this
to arm64 Kconfig:

config ARCH_HAS_CPU_RELAX
	def_bool y

Otherwise,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
