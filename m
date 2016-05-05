Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:63231 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcEEQaL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2016 12:30:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/8] asm-generic/io.h: add io{read,write}64 accessors
Date: Thu, 05 May 2016 18:29:53 +0200
Message-ID: <4710958.T0fVy9H8Sa@wuerfel>
In-Reply-To: <1462462556-27684-1-git-send-email-horia.geanta@nxp.com>
References: <1462462435-27403-1-git-send-email-horia.geanta@nxp.com> <1462462556-27684-1-git-send-email-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Horia =?utf-8?B?R2VhbnTEgw==?= <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Scott Wood <scott.wood@nxp.com>, Alexandru Porosanu <alexandru.porosanu@nxp.com>, Tudor Ambarus <tudor-dan.ambarus@nxp.com>, Cristian Stoica <cristian.stoica@nxp.com>
Message-ID: <20160505162953.FxS4so_6HjuxKR8M-dg0r6Slm-ckidUKGLvwWp9XLME@z>

On Thursday 05 May 2016 18:35:56 Horia Geantă wrote:
> This will allow device drivers to consistently use io{read,write}XX
> also for 64-bit accesses.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
