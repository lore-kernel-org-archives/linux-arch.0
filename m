Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:48642 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcEJJdg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2016 05:33:36 -0400
Date: Tue, 10 May 2016 17:33:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 2/8] asm-generic/io.h: add io{read,write}64 accessors
Message-ID: <20160510093321.GA15677@gondor.apana.org.au>
References: <1462462435-27403-1-git-send-email-horia.geanta@nxp.com>
 <1462462556-27684-1-git-send-email-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1462462556-27684-1-git-send-email-horia.geanta@nxp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Scott Wood <scott.wood@nxp.com>, Alexandru Porosanu <alexandru.porosanu@nxp.com>, Tudor Ambarus <tudor-dan.ambarus@nxp.com>, Cristian Stoica <cristian.stoica@nxp.com>
Message-ID: <20160510093321.gG_IQ5dtLOXtKm6ZEqodGOmn2QqMaWTzE5JitTfkru0@z>

On Thu, May 05, 2016 at 06:35:56PM +0300, Horia Geantă wrote:
> This will allow device drivers to consistently use io{read,write}XX
> also for 64-bit accesses.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

I don't see patch 1/8.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
