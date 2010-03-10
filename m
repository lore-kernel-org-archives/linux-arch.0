From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 6/6] sparc64: use early_res and nobootmem
Date: Wed, 10 Mar 2010 13:30:35 -0800 (PST)
Message-ID: <20100310.133035.84824445.davem@davemloft.net>
References: <1268256267-3769-1-git-send-email-yinghai@kernel.org>
	<1268256267-3769-7-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40772
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753802Ab0CJVaP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 16:30:15 -0500
In-Reply-To: <1268256267-3769-7-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yinghai@kernel.org
Cc: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 10 Mar 2010 13:24:27 -0800

> use early_res/fw_memmap to replace lmb, so could use early_res replace bootme
> later.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Why?  What does early_res/fw_memmap do that lmb cannot?
