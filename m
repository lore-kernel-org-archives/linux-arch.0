Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13202
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932224AbWBCJkH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Feb 2006 04:40:07 -0500
Date: Fri, 03 Feb 2006 01:38:53 -0800 (PST)
Message-Id: <20060203.013853.126416970.davem@davemloft.net>
Subject: Re: percpu data changes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060203013521.3696aa64.akpm@osdl.org>
References: <20060203011748.6fe3fee3.akpm@osdl.org>
	<20060203011835.556f5199.akpm@osdl.org>
	<20060203013521.3696aa64.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: starvik@axis.com, dhowells@redhat.com, kyle@parisc-linux.org, anton@samba.org, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, wli@holomorphy.com, ak@muc.de, chris@zankel.net, phil.el@wanadoo.fr, nathans@sgi.com, axboe@suse.de, linux-arch@vger.kernel.org, dada1@cosmosbay.com
List-ID: <linux-arch.vger.kernel.org>

From: Andrew Morton <akpm@osdl.org>
Date: Fri, 3 Feb 2006 01:35:21 -0800

> A couple more.
> 
>  net/core/dev.c   |    2 +-
>  net/core/utils.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Looks good to me, please merge this in Andrew.
