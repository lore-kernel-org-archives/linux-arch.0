From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 08/31] arm64: CPU support
Date: Fri, 7 Sep 2012 19:24:38 +0000
Message-ID: <201209071924.38430.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> +
> +#include <asm/cputable.h>
> +
> +extern unsigned long __cpu_setup(void);
> +
> +struct cpu_info __initdata cpu_table[] = {
> +	{
> +		.cpu_id_val	= 0x000f0000,
> +		.cpu_id_mask	= 0x000f0000,
> +		.cpu_name	= "AArch64 Processor",
> +		.cpu_setup	= __cpu_setup,
> +	},
> +	{ /* Empty */ },
> +};

> +#define MAIR(attr, mt)	((attr) << ((mt) * 8))
> +
> +ENTRY(cpu_proc_init)
> +	ret
> +ENDPROC(cpu_proc_init)
> +
> +ENTRY(cpu_proc_fin)
> +	ret
> +ENDPROC(cpu_proc_fin)


These seem to be leftovers from multi-cpu support that can be removed.

	Arnd
