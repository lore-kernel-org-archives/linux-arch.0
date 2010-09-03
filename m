Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51456 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754Ab0ICMTN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2010 08:19:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -mm 8/8] add the common dma_addr_t typedef to include/linux/types.h
Date: Fri, 3 Sep 2010 14:19:09 +0200
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp> <1283474956-14710-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1283474956-14710-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201009031419.09298.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20100903121909.n1GdbprHQeV859Nfsnph-HbJOyFB3wCl5GPf6ovpKTY@z>

On Friday 03 September 2010, FUJITA Tomonori wrote:
> All architectures can use the common dma_addr_t typedef now. We can
> remove the arch specific dma_addr_t.

Very nice!

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: arnd@arndb.de

Acked-by: Arnd Bergmann <arnd@arndb.de>
