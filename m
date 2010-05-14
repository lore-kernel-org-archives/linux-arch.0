From: Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH 11/35] lmb: Add find_memory_core_early()
Date: Fri, 14 May 2010 09:44:46 -0700
Message-ID: <4BED7DFE.2090108@oracle.com>
References: <1273804238.21352.389.camel@pasglop>	<4BECF00D.6080800@oracle.com>	<1273825187.21352.590.camel@pasglop> <20100514.013012.13730149.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:26781 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab0ENQk3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2010 12:40:29 -0400
In-Reply-To: <20100514.013012.13730149.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 05/14/2010 01:30 AM, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 14 May 2010 18:19:47 +1000
>
>   
>> OK, I'll have to let Davem deal with the fine point of the sparc bits,
>> but I think basically sparc has CONFIG_ARCH_POPULATES_NODE_MAP set, but
>> the way it's NUMA affinity works, the early_node_map[] is crap, you
>> cannot rely on the ranges in there.
>>     
>   

> Right, we can't use early_node_map[] on sparc, because the NUMA
> mappings are far too granular to use that kind of representation.
>   
good to know.

early_node_map[] doesn't have enough slot?

YH
