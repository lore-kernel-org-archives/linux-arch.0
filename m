From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/27] score: create head files elf.h emergency-restart.h errno.h
Date: Tue, 9 Jun 2009 19:20:09 +0200
Message-ID: <200906091920.09781.arnd@arndb.de>
References: <OF1B185198.8D225D85-ON482575D0.00235FF4-482575D0.0023D06F@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55009 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZFIRUW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:20:22 -0400
In-Reply-To: <OF1B185198.8D225D85-ON482575D0.00235FF4-482575D0.0023D06F@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> --- /dev/null
> +++ b/arch/score/include/asm/errno.h
> @@ -0,0 +1,7 @@
> +#ifndef _ASM_SCORE_ERRNO_H
> +#define _ASM_SCORE_ERRNO_H
> +
> +#include <asm-generic/errno.h>
> +#define EMAXERRNO 1024
> +
> +#endif /* _ASM_SCORE_ERRNO_H */

EMAXERRNO is mips specific right now. Do you actually need it somewhere?

	Arnd <><
