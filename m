From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 05/19] Add common asm-offsets.h
Date: Mon, 04 May 2015 16:46:54 +0200
Message-ID: <13401673.RIGalftL9M@wuerfel>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp> <1430736122-20929-7-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60592 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbEDOrD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 10:47:03 -0400
In-Reply-To: <1430736122-20929-7-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 04 May 2015 19:41:48 Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/asm-generic/asm-offsets.h | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 include/asm-generic/asm-offsets.h
> 
> diff --git a/include/asm-generic/asm-offsets.h b/include/asm-generic/asm-offsets.h
> new file mode 100644
> index 0000000..d370ee3
> --- /dev/null
> +++ b/include/asm-generic/asm-offsets.h
> @@ -0,0 +1 @@
> +#include <generated/asm-offsets.h>
> 

Please add  a short patch description, and my "Acked-by: Arnd Bergmann
<arnd@arndb.de>", so it can get merged through your tree.

	Arnd
