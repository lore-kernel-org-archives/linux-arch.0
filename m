From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Move most arches to asm-generic/current.h
Date: Mon, 23 Apr 2012 23:30:09 -0400 (EDT)
Message-ID: <20120423.233009.1036274421495158511.davem@davemloft.net>
References: <1335237509-17113-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:34920 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535Ab2DXDaQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Apr 2012 23:30:16 -0400
In-Reply-To: <1335237509-17113-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sboyd@codeaurora.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 23 Apr 2012 20:18:29 -0700

> Make get_current() into a static inline function in the
> generic version of current.h so we match what almost every
> architecture is doing. This allows us to move most of the arches
> over to this generic header instead of redefining the same thing
> over and over in each asm directory.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-arch@vger.kernel.org

For sparc bits:

Acked-by: David S. Miller <davem@davemloft.net>
