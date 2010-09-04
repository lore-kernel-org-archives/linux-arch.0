From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH -mm 0/8] unify dma_addr_t typedef
 (CONFIG_ARCH_DMA_ADDR_T_64BIT)
Date: Sat, 4 Sep 2010 15:58:51 +0900
Message-ID: <20100904155738W.fujita.tomonori@lab.ntt.co.jp>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
	<20100903150948.4b612498.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:52301 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab0IDG7C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 4 Sep 2010 02:59:02 -0400
In-Reply-To: <20100903150948.4b612498.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, 3 Sep 2010 15:09:48 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> Am I correct in believing that we can merge the first seven patches
> into arch trees at any time and, once they are all merged, patch 8/8
> can then go into mainline?

Yes. The first seven patches simply introduce
ARCH_DMA_ADDR_T_64BIT. They don't affect the existing code.

Thanks,
