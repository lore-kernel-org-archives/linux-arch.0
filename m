From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] starfire: use BUILD_BUG_ON for netdrv_addr_t
Date: Sun, 29 Aug 2010 21:25:34 -0700 (PDT)
Message-ID: <20100829.212534.242147552.davem@davemloft.net>
References: <1282972125-9968-1-git-send-email-akinobu.mita@gmail.com>
	<20100828.154125.246523501.davem@davemloft.net>
	<20100830075830R.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20100830075830R.fujita.tomonori@lab.ntt.co.jp>
Sender: netdev-owner@vger.kernel.org
To: fujita.tomonori@lab.ntt.co.jp
Cc: akinobu.mita@gmail.com, netdev@vger.kernel.org, ionut@badula.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 30 Aug 2010 07:59:38 +0900

> But the above can't be perfect so about twenty architectures define
> dma_addr_t. With CONFIG_DMA_ADDR_T_64BIT, we can clean up all the
> mess nicely, I guess.

Yes, that's what we need.
