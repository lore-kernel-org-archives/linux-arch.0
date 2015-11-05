From: David Miller <davem@davemloft.net>
Subject: Re: [RFC] Enable ARCH_USE_BUILTIN_BSWAP by default
Date: Thu, 05 Nov 2015 15:33:49 -0500 (EST)
Message-ID: <20151105.153349.1685476243212429659.davem@davemloft.net>
References: <1446044032.3405.241.camel@infradead.org>
	<20151028.184415.373814461753571638.davem@davemloft.net>
	<1446087994.3405.277.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:38888 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbbKEUdv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2015 15:33:51 -0500
In-Reply-To: <1446087994.3405.277.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dwmw2@infradead.org
Cc: linux-arch@vger.kernel.org, fengguang.wu@intel.com

From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 29 Oct 2015 12:06:34 +0900

> I wonder if we could provide a generic weak version in the lib/
> directory which just uses the existing __arch_swab32 et al? Does GCC
> use a standard function call ABI for __bswap[sd]i2 or can it be
> 'special'?

That's undesirable compared to inlining the asm.
