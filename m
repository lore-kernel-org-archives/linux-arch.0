From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 11/35] lmb: Add find_memory_core_early()
Date: Fri, 14 May 2010 01:30:12 -0700 (PDT)
Message-ID: <20100514.013012.13730149.davem@davemloft.net>
References: <1273804238.21352.389.camel@pasglop>
	<4BECF00D.6080800@oracle.com>
	<1273825187.21352.590.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57920
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754271Ab0ENIaH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 May 2010 04:30:07 -0400
In-Reply-To: <1273825187.21352.590.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: yinghai.lu@oracle.com, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 May 2010 18:19:47 +1000

> OK, I'll have to let Davem deal with the fine point of the sparc bits,
> but I think basically sparc has CONFIG_ARCH_POPULATES_NODE_MAP set, but
> the way it's NUMA affinity works, the early_node_map[] is crap, you
> cannot rely on the ranges in there.

Right, we can't use early_node_map[] on sparc, because the NUMA
mappings are far too granular to use that kind of representation.
