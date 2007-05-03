Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42745
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1031292AbXECU2A (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 May 2007 16:28:00 -0400
Date: Thu, 03 May 2007 13:28:01 -0700 (PDT)
Message-Id: <20070503.132801.68856382.davem@davemloft.net>
Subject: Re: gcc generating calls to __udivdi3
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070503173842.GC10249@linux-mips.org>
References: <20070503173842.GC10249@linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: ralf@linux-mips.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 3 May 2007 18:38:42 +0100

> Forwarding this to linux-arch mostly as a heads up to other arch maintainers
> and discussion.  With gcc's optimizer getting increasingly smarter I'm not
> so sure if below patch is the right thing.  In timespec_add_ns we would
> normally except the loop to be interated once at most and gcc should make
> this assumption due to the unlikely() hint.  Anyway, we have to be
> prepared for more such code transformations to happen so adding a __udivdi3
> implementation is probably the defensive approach.

I would rather not have it there and therefore know when such
an expensive operation is being emitted by gcc.

It looks like the divide costs might be set wrong on MIPS
in gcc if it thinks udivdi3 is cheaper than this loop.
