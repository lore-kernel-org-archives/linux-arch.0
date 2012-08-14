From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 03/31] arm64: Exception handling
Date: Tue, 14 Aug 2012 16:29:07 -0700
Message-ID: <20120814232907.GB19607@quad.lixom.net>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33372 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab2HNX3H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 19:29:07 -0400
Received: by ggdk6 with SMTP id k6so1140979ggd.19
        for <linux-arch@vger.kernel.org>; Tue, 14 Aug 2012 16:29:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>

Hi,

This one is a bit denser, so just a quick first pass with a couple of minor
comments. I'll revisit the rest.

On Tue, Aug 14, 2012 at 06:52:04PM +0100, Catalin Marinas wrote:

> +el1_sp_pc:
> +	/*
> +	 *Stack or PC alignment exception handling
> +	 */
> +	mrs	x0, far_el1
> +	mov	x1, x25
> +	mov	x2, sp
> +	b	do_sp_pc_abort
> +el1_undef:
> +	/*
> +	 *Undefined instruction
> +	 */

Nit: Missing spaces in the comment here and the one above.

> +el0_undef:
> +	/*
> +	 *Undefined instruction
> +	 */
> +	mov	x0, sp
> +	b	do_undefinstr

Here too.

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> new file mode 100644
> index 0000000..8712a8e
> --- /dev/null
> +++ b/arch/arm64/kernel/traps.c
[...]
> +DEFINE_SPINLOCK(die_lock);

Should probably be static.
