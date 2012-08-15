From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 02/31] arm64: Kernel booting and initialisation
Date: Wed, 15 Aug 2012 13:20:02 +0000
Message-ID: <201208151320.02313.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51799 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab2HONUI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 09:20:08 -0400
In-Reply-To: <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +The AArch64 exception model is made up of a number of exception levels
> +(EL0 - EL3), with EL0 and EL1 having a secure and a non-secure
> +counterpart.  EL2 is the hypervisor level and exists only in non-secure
> +mode. EL3 is the highest priority level and exists only in secure mode.

I'm always confused by a description like this. It sounds like you cannot
have a hypervisor if you have code running in secure mode in EL3. What
I instead understand is that you enter non-secure mode by going from
EL3 into EL2.

> +2. Setup the device tree
> +-------------------------
> +
> +Requirement: MANDATORY
> +
> +The device tree blob (dtb) must be no bigger than 2 megabytes in size
> +and placed at a 2-megabyte boundary within the first 512 megabytes from
> +the start of the kernel image. This is to allow the kernel to map the
> +blob using a single section mapping in the initial page tables.

I've seen people put firmware for some peripherals into the device tree,
so that a device driver can grab a blob from there and load it into the
device, rather than calling request_firmware() which would fail if the
OS running on the system does not contain the blob. If such firmware is
too large, you end up violating the 2 MB limit you impose here.

Should we keep that limit and declare those use cases as invalid, or
should we try to make the boot protocol more flexible?

> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> new file mode 100644
> index 0000000..d766493
> --- /dev/null
> +++ b/arch/arm64/include/asm/setup.h
> @@ -0,0 +1,26 @@
> +#ifndef __ASM_SETUP_H
> +#define __ASM_SETUP_H
> +
> +#include <linux/types.h>
> +
> +#define COMMAND_LINE_SIZE 1024
> +
> +#endif

Is this necessary? The asm-generic version of this file allows 512 bytes,
which seems plenty.

> +unsigned int processor_id;
> +EXPORT_SYMBOL(processor_id);
> +
> +unsigned int elf_hwcap __read_mostly;
> +EXPORT_SYMBOL(elf_hwcap);

EXPORT_SYMBOL_GPL?

Neither of these looks like they should be used in drivers.

	Arnd
