Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:41925 "EHLO
        helcar.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750778AbdCAF5i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 00:57:38 -0500
Date: Wed, 1 Mar 2017 12:52:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v8 08/11] cryptouser.h: fix include from userland
Message-ID: <20170301045241.GB9156@gondor.apana.org.au>
References: <20170228024844.GA28691@altlinux.org>
 <1488314857-28327-1-git-send-email-nicolas.dichtel@6wind.com>
 <1488314857-28327-9-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1488314857-28327-9-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de, ldv@altlinux.org, linux-rdma@vger.kernel.org
Message-ID: <20170301045241.dQ8SwBKRuty82bBRblCx_iz1wHeppheadrMTpm5FbJo@z>

On Tue, Feb 28, 2017 at 09:47:34PM +0100, Nicolas Dichtel wrote:
> This patch prepares the uapi export by fixing the following error:
> 
> .../linux/cryptouser.h:58:16: error: ‘CRYPTO_MAX_ALG_NAME’ undeclared here (not in a function)
>   char cru_name[CRYPTO_MAX_ALG_NAME];
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  include/linux/crypto.h          | 2 +-
>  include/uapi/linux/cryptouser.h | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index c0b0cf3d2d2f..4cf29a35bb4b 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> +#include <uapi/linux/cryptouser.h>

Nack.  cryptouser is just one interface in the crypto API.  It
should not be included by every single crypto user in the kernel.

You could perhaps introduce a new file under uapi just for this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
