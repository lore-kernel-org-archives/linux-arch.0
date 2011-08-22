From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/24] C6X: headers
Date: Mon, 22 Aug 2011 23:14:33 +0200
Message-ID: <1328178.VkYhLNAX5s@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-19-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49351 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab1HVVPF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 17:15:05 -0400
In-Reply-To: <1314043785-2880-19-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:39 Mark Salter wrote:
> Signed-off-by: Mark Salter <msalter@redhat.com>

> 
> diff --git a/arch/c6x/include/asm/asm-offsets.h b/arch/c6x/include/asm/asm-offsets.h
> new file mode 100644
> index 0000000..d370ee3
> --- /dev/null
> +++ b/arch/c6x/include/asm/asm-offsets.h
> @@ -0,0 +1 @@
> +#include <generated/asm-offsets.h>

I wonder if it makes sense to install this file in asm-generic/asm-offsets.h
and referencing it like the other files.

> +#include <asm-generic/bitops/hweight.h>

Do you have an instruction that can be used for hweight? That is often a useful
optimization.

	Arnd
