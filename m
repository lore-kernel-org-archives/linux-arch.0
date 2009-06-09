From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/27] score: create head files bitops.h bitsperlong.h bug.h bugs.h byteorder.h
Date: Tue, 9 Jun 2009 18:50:57 +0200
Message-ID: <200906091850.58266.arnd@arndb.de>
References: <OFBB948A5B.D38E1AE1-ON482575D0.00233280-482575D0.0023A73C@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59070 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZFIQv3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 12:51:29 -0400
In-Reply-To: <OFBB948A5B.D38E1AE1-ON482575D0.00233280-482575D0.0023A73C@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:

> diff --git a/arch/score/include/asm/bitops.h 
> b/arch/score/include/asm/bitops.h
> new file mode 100644
> index 0000000..2763b05
> --- /dev/null
> +++ b/arch/score/include/asm/bitops.h
> @@ -0,0 +1,16 @@
> +#ifndef _ASM_SCORE_BITOPS_H
> +#define _ASM_SCORE_BITOPS_H
> +
> +#include <asm/byteorder.h> /* swab32 */
> +#include <asm/system.h> /* save_flags */
> +
> +/*
> + * clear_bit() doesn't provide any barrier for the compiler.
> + */
> +#define smp_mb__before_clear_bit()     barrier()
> +#define smp_mb__after_clear_bit()      barrier()
> +
> +#include <asm-generic/bitops.h>
> +#include <asm-generic/bitops/__fls.h>
> +
> +#endif /* _ASM_SCORE_BITOPS_H */

I guess you tried using the asm-generic version of this file and
failed. Since you don't do anything architecture specific in
here, that could well mean that my version needs to be fixed.
What problem did you see?

	Arnd <><
