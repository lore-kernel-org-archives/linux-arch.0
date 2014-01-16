From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH net-next] etherdevice: Use ether_addr_copy to copy
 an Ethernet address
Date: Wed, 15 Jan 2014 16:45:40 -0800 (PST)
Message-ID: <20140115.164540.450877805879786067.davem@davemloft.net>
References: <1389741527.24849.68.camel@joe-AO722>
	<20140115.153951.743060257410154565.davem@davemloft.net>
	<1389830878.14001.39.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42958 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbaAPApn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2014 19:45:43 -0500
In-Reply-To: <1389830878.14001.39.camel@joe-AO722>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: joe@perches.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Wed, 15 Jan 2014 16:07:58 -0800

> If you want the ones for net-next net/ now (but not
> for batman-adv, that maybe could use a new function like
> ether_addr_copy_unaligned) here's a changestat.
> 
> Otherwise, I'll wait for the next cycle.

This looks fine, why don't you toss it my way over the weekend as I
still have some backlog to process at the moment?

Thanks.
