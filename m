Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21650
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932226AbWBCJkv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Feb 2006 04:40:51 -0500
Date: Fri, 03 Feb 2006 01:40:12 -0800 (PST)
Message-Id: <20060203.014012.88360312.davem@davemloft.net>
Subject: Re: percpu data changes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060203011748.6fe3fee3.akpm@osdl.org>
References: <20060203011748.6fe3fee3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: starvik@axis.com, dhowells@redhat.com, kyle@parisc-linux.org, anton@samba.org, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, wli@holomorphy.com, ak@muc.de, chris@zankel.net, phil.el@wanadoo.fr, nathans@sgi.com, axboe@suse.de, linux-arch@vger.kernel.org, dada1@cosmosbay.com
List-ID: <linux-arch.vger.kernel.org>

From: Andrew Morton <akpm@osdl.org>
Date: Fri, 3 Feb 2006 01:17:48 -0800

> So please review the below post-2.6.16 patch with an eye to the following:
> 
> - Any stuff you don't want added to your arch
> 
> - Any code which _does_ affect percpu data and which might possibly be
>   used on powerpc.  Such changes will need to go into 2.6.16.
> 
> Thanks.

Sparc64 bits look fine to me.
