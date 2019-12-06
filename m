Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfLFQ4K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 11:56:10 -0500
Subject: Re: [PATCH 1/3] cpuinfo: add sysfs based arch independent cpuinfo
 framework
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-2-trenn@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <65a20b22-8cc9-4492-25d5-4f03727086e8@infradead.org>
Date: Fri, 6 Dec 2019 08:56:02 -0800
MIME-Version: 1.0
In-Reply-To: <20191206162421.15050-2-trenn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org, fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>
Message-ID: <20191206165602.5yNIaMuUkWb24u8aYRVldG4dB80l810ee0JvsGl1Wwg@z>

On 12/6/19 8:24 AM, Thomas Renninger wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 48b5e103bdb0..39015570b1ca 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -882,6 +882,17 @@ config STRICT_MODULE_RWX
>  	  and non-text memory will be made non-executable. This provides
>  	  protection against certain security exploits (e.g. writing to text)
>  
> +config CPUINFO_SYSFS
> +	bool "Provides processor information in sysfs. Successor of /proc/cpuinfo"

	      Provide

> +	def_bool y
> +	depends on HAVE_CPUINFO_SYSFS
> +	help
> +	  Provides architecture specific processor information in /sys/devices/system/cpu/info> +	  Use this instead of /proc/cpuinfo

End those 2 sentences with periods (full stop), please.

> +
> +config HAVE_CPUINFO_SYSFS
> +	bool
> +
>  # select if the architecture provides an asm/dma-direct.h header
>  config ARCH_HAS_PHYS_TO_DMA
>  	bool


-- 
~Randy
