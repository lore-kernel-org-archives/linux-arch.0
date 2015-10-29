From: David Miller <davem@davemloft.net>
Subject: Re: [RFC] Enable ARCH_USE_BUILTIN_BSWAP by default
Date: Wed, 28 Oct 2015 18:44:15 -0700 (PDT)
Message-ID: <20151028.184415.373814461753571638.davem@davemloft.net>
References: <1446044032.3405.241.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51462 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbbJ2B1u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2015 21:27:50 -0400
In-Reply-To: <1446044032.3405.241.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dwmw2@infradead.org
Cc: linux-arch@vger.kernel.org, fengguang.wu@intel.com

From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 28 Oct 2015 23:53:52 +0900

> I know MIPS will need some additional libgcc functionality brought
> into the kernel, and Ralf has already been looking at that; not sure
> about other platforms. Let's find out :)

It should properly build on Sparc, but I still need to do my due
diligence to see if gcc will actually emit the little-endian loads
and stores or not...
