From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 18/57] sparc: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 13:40:07 -0400 (EDT)
Message-ID: <20110921.134007.1812828154454173068.davem@davemloft.net>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-19-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:48728 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1IURlY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2011 13:41:24 -0400
In-Reply-To: <1316597339-29861-19-git-send-email-yong.zhang0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yong.zhang0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, joe@perches.com, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org

From: Yong Zhang <yong.zhang0@gmail.com>
Date: Wed, 21 Sep 2011 17:28:19 +0800

> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
