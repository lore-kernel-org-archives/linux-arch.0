Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64180 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab2IGTYr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:24:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 08/31] arm64: CPU support
Date: Fri, 7 Sep 2012 19:24:38 +0000
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Message-ID: <201209071924.38430.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20120907192438.GMmvDykVHRbdRDial-0GsOqj1O-BXfMF-mPSogLHScI@z>

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
