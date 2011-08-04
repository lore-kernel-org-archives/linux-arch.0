Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:60299 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1HDKQl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Aug 2011 06:16:41 -0400
Date: Thu, 04 Aug 2011 03:13:56 -0700 (PDT)
Message-ID: <20110804.031356.626082809394107925.davem@davemloft.net>
Subject: Re: [PATCH 16/23] sparc: Use HAVE_MEMBLOCK_NODE_MAP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110804095218.GB2731@htj.dyndns.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
	<1311694534-5161-17-git-send-email-tj@kernel.org>
	<20110804095218.GB2731@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tj@kernel.org
Cc: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, sparclinux@vger.kernel.org
Message-ID: <20110804101356.K705_w5r8yVDJIehGPGYfgFIu9Sp8zhQXSw984bJJXk@z>

From: Tejun Heo <tj@kernel.org>
Date: Thu, 4 Aug 2011 11:52:18 +0200

> On Tue, Jul 26, 2011 at 05:35:27PM +0200, Tejun Heo wrote:
>> sparc doesn't access early_node_map[] directly and enabling
>> HAVE_MEMBLOCK_NODE_MAP is trivial - replacing add_active_range() calls
>> with memblock_set_node() and selecting HAVE_MEMBLOCK_NODE_MAP is
>> enough.
>> 
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
> 
> David just confirmed this worked fine on sparc and was okay with this
> going through tip.

Yep:

Acked-by: David S. Miller <davem@davemloft.net>
