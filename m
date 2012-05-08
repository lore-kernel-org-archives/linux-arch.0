From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/6] get_unmapped_area checks for TASK_SIZE before
 MAP_FIXED on sparc64
Date: Tue, 08 May 2012 13:00:32 -0400 (EDT)
Message-ID: <20120508.130032.416753327609206678.davem@davemloft.net>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
	<1336488022-3723-5-git-send-email-murzin.v@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:59566 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772Ab2EHRCq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 13:02:46 -0400
In-Reply-To: <1336488022-3723-5-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: murzin.v@gmail.com
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, lethal@linux-sh.org, linux@arm.linux.org.uk

From: Vladimir Murzin <murzin.v@gmail.com>
Date: Tue,  8 May 2012 18:40:20 +0400

> Move check for TASK_SIZE before MAP_FIXED in sparc64's
> arch_get_unmapped_area() and arch_get_unmapped_area_topdown().
> 
> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
