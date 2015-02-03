Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51793 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbbBCIke (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 03:40:34 -0500
Date: Tue, 03 Feb 2015 00:40:31 -0800 (PST)
Message-ID: <20150203.004031.593368249759204527.davem@davemloft.net>
Subject: Re: [RFC] change non-atomic bitops method
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150202223851.f30768d0.akpm@linux-foundation.org>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
	<20150202223851.f30768d0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: Yalin.Wang@sonymobile.com, kirill@shutemov.name, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
Message-ID: <20150203084031.L21qgFq7LuO04Z9KKbxsgKy_jxyDgmgrDaTKfsy9bc8@z>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 2 Feb 2015 22:38:51 -0800

> It is only with both these ratios that we can work out whether the
> patch is a net gain.  My suspicion is that set_bit on an already-set
> bit is so rare that the patch will be a loss.

A common pattern is implementing a "referenced" bit, and in that case
the bit is often already set, and in such a scenerio the proposed
change is a huge win.

