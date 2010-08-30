From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] starfire: use BUILD_BUG_ON for netdrv_addr_t
Date: Mon, 30 Aug 2010 13:57:53 +0900
Message-ID: <20100830135711N.fujita.tomonori@lab.ntt.co.jp>
References: <20100828.154125.246523501.davem@davemloft.net>
	<20100830075830R.fujita.tomonori@lab.ntt.co.jp>
	<20100829.212534.242147552.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:34791 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935Ab0H3E6T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Aug 2010 00:58:19 -0400
In-Reply-To: <20100829.212534.242147552.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: davem@davemloft.net
Cc: fujita.tomonori@lab.ntt.co.jp, akinobu.mita@gmail.com, netdev@vger.kernel.org, ionut@badula.org, linux-arch@vger.kernel.org

On Sun, 29 Aug 2010 21:25:34 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Date: Mon, 30 Aug 2010 07:59:38 +0900
> 
> > But the above can't be perfect so about twenty architectures define
> > dma_addr_t. With CONFIG_DMA_ADDR_T_64BIT, we can clean up all the
> > mess nicely, I guess.
> 
> Yes, that's what we need.

Ok, I'll take care of this.
