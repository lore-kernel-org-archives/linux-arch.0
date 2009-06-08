Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:59395 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZFHIta (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2009 04:49:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 8 Jun 2009 10:49:22 +0200
References: <200906041747.04310.arnd@arndb.de> <200906081003.59171.arnd@arndb.de> <20090608172200A.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090608172200A.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <200906081049.23045.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090608084922.39aVbmA-jKUWInn_2-gJBug2dztJhmg2hl96UskpGw0@z>

On Monday 08 June 2009, FUJITA Tomonori wrote:

> If you don't clean up them, I think that it's better to leave out
> asm-generic/dma-generic-linear.h for
> now. asm-generic/dma-generic-linear.h is supposed to clean up the
> mess; unify (generalize, or fix) some architecture. It's not supported
> to add another temporary hack that should be removed.

Ok. I have no more ideas on how to do that in a cleaner way
than what I suggested, so I'll stop bothering you with it.

	Arnd <><
