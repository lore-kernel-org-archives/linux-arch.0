From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 8 Jun 2009 10:49:22 +0200
Message-ID: <200906081049.23045.arnd@arndb.de>
References: <200906041747.04310.arnd@arndb.de> <200906081003.59171.arnd@arndb.de> <20090608172200A.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754453AbZFHItk@vger.kernel.org>
In-Reply-To: <20090608172200A.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 08 June 2009, FUJITA Tomonori wrote:

> If you don't clean up them, I think that it's better to leave out
> asm-generic/dma-generic-linear.h for
> now. asm-generic/dma-generic-linear.h is supposed to clean up the
> mess; unify (generalize, or fix) some architecture. It's not supported
> to add another temporary hack that should be removed.

Ok. I have no more ideas on how to do that in a cleaner way
than what I suggested, so I'll stop bothering you with it.

	Arnd <><
