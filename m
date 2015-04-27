From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 02/17] h8300: UAPI headers
Date: Mon, 27 Apr 2015 10:43:14 +0200
Message-ID: <43964209.HMXbXhrAJP@wuerfel>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp> <1430112924-1134-3-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:53017 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbD0In1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2015 04:43:27 -0400
In-Reply-To: <1430112924-1134-3-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 27 April 2015 14:35:09 Yoshinori Sato wrote:
> diff --git a/arch/h8300/include/uapi/asm/auxvec.h b/arch/h8300/include/uapi/asm/auxvec.h
> new file mode 100644
> index 0000000..1d36fe38
> --- /dev/null
> +++ b/arch/h8300/include/uapi/asm/auxvec.h
> @@ -0,0 +1,4 @@
> +#ifndef __ASMH8300_AUXVEC_H
> +#define __ASMH8300_AUXVEC_H
> +
> +#endif

> diff --git a/arch/h8300/include/uapi/asm/swab.h b/arch/h8300/include/uapi/asm/swab.h
> new file mode 100644
> index 0000000..7847e56
> --- /dev/null
> +++ b/arch/h8300/include/uapi/asm/swab.h
> @@ -0,0 +1 @@
> +#include <asm-generic/swab.h>


Two more files that you can just use in the generic version here.

> diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
> new file mode 100644
> index 0000000..af3a6c3
> --- /dev/null
> +++ b/arch/h8300/include/uapi/asm/signal.h

I think you should use the asm-generic version here, not just to make your
code smaller, but also to ensure you have the gneeric ABI.

	Arnd
