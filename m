From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] Add and use WARN_RATELIMIT
Date: Mon, 23 May 2011 17:38:06 -0400 (EDT)
Message-ID: <20110523.173806.1174406351709452162.davem@davemloft.net>
References: <1305666832.1722.62.camel@Joe-Laptop>
	<cover.1305999731.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:41682 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab1EWViS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2011 17:38:18 -0400
In-Reply-To: <cover.1305999731.git.joe@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: joe@perches.com
Cc: greearb@candelatech.com, linux-arch@vger.kernel.org, arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Sat, 21 May 2011 10:48:38 -0700

> Generic mechanism to ratelimit WARN uses.
> 
> Joe Perches (2):
>   bug.h: Add WARN_RATELIMIT
>   net: filter: Use WARN_RATELIMIT
> 
>  include/asm-generic/bug.h |   16 ++++++++++++++++
>  net/core/filter.c         |    4 +++-
>  2 files changed, 19 insertions(+), 1 deletions(-)

This looks fine to me, and no objections have been voiced otherwise,
so applied to net-2.6, thanks!
