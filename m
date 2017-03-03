Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:56763 "EHLO
        helcar.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751340AbdCCJ6E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2017 04:58:04 -0500
Date: Fri, 3 Mar 2017 17:35:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v9 08/11] cryptouser.h: fix include from userland
Message-ID: <20170303093538.GA26163@gondor.apana.org.au>
References: <20170301045241.GB9156@gondor.apana.org.au>
 <1488473802-13354-1-git-send-email-nicolas.dichtel@6wind.com>
 <1488473802-13354-9-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1488473802-13354-9-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de, ldv@altlinux.org, linux-rdma@vger.kernel.org
Message-ID: <20170303093538.h_r-EFAZ1R0dBUkRDivp6djtflTs2C8Cu9gLnegXooY@z>

On Thu, Mar 02, 2017 at 05:56:39PM +0100, Nicolas Dichtel wrote:
> This patch prepares the uapi export by fixing the following error:
> 
> .../linux/cryptouser.h:58:16: error: ‘CRYPTO_MAX_ALG_NAME’ undeclared here (not in a function)
>   char cru_name[CRYPTO_MAX_ALG_NAME];
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
