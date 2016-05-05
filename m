From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/8] asm-generic/io.h: add io{read,write}64 accessors
Date: Thu, 05 May 2016 18:29:53 +0200
Message-ID: <4710958.T0fVy9H8Sa@wuerfel>
References: <1462462435-27403-1-git-send-email-horia.geanta@nxp.com> <1462462556-27684-1-git-send-email-horia.geanta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1462462556-27684-1-git-send-email-horia.geanta@nxp.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Horia =?utf-8?B?R2VhbnTEgw==?= <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Scott Wood <scott.wood@nxp.com>, Alexandru Porosanu <alexandru.porosanu@nxp.com>, Tudor Ambarus <tudor-dan.ambarus@nxp.com>, Cristian Stoica <cristian.stoica@nxp.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 05 May 2016 18:35:56 Horia Geant=C4=83 wrote:
> This will allow device drivers to consistently use io{read,write}XX
> also for 64-bit accesses.
>=20
> Signed-off-by: Horia Geant=C4=83 <horia.geanta@nxp.com>
>=20

Acked-by: Arnd Bergmann <arnd@arndb.de>
