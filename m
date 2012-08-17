From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 02/31] arm64: Kernel booting and initialisation
Date: Fri, 17 Aug 2012 01:56:15 -0700
Message-ID: <20120817085615.GO11011@atomide.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26325 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab2HQI4T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Aug 2012 04:56:19 -0400
Content-Disposition: inline
In-Reply-To: <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>

* Catalin Marinas <catalin.marinas@arm.com> [120814 11:00]:
> +3. Decompress the kernel image
> +------------------------------
> +
> +Requirement: OPTIONAL
> +
> +The AArch64 kernel does not provide a decompressor and therefore
> +requires gzip decompression to be performed by the boot loader if the
> +default Image.gz target is used.  For bootloaders that do not implement
> +this requirement, the larger Image target is available instead.

Maybe add something here about why AArch64 does not provide a
decompressor? That's something everybody will wonder while reading
this part.

> +- Caches, MMUs
> +  The MMU must be off.
> +  Instruction cache may be on or off.
> +  Data cache must be off and invalidated.

External caches must be configured by bootloader but set to disabled
state?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
