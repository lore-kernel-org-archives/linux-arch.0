From: Yinghai <yinghai.lu@oracle.com>
Subject: Re: [PATCH 15/39] lmb: Add lmb_find_area_node()
Date: Mon, 12 Apr 2010 21:37:09 -0700
Message-ID: <4BC3F4F5.9010601@oracle.com>
References: <1270793048-23796-1-git-send-email-yinghai@kernel.org>	 <1270793048-23796-16-git-send-email-yinghai@kernel.org> <1271132330.13059.64.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:35667 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab0DMEj7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2010 00:39:59 -0400
In-Reply-To: <1271132330.13059.64.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 04/12/2010 09:18 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-04-08 at 23:03 -0700, Yinghai Lu wrote:
>> It can be used to find NODE_DATA for numa.
>>
>> Need to make sure early_node_map[] is filled before it is called, otherwise
>> it will fallback to lmb_find_area(), with node range.
> 
> Isn't that more duplication from what's already in there for nid
> handling ? (Which btw may not be optimal, simply what I'm saying is that
> all that stuff should be factored).

maybe could try to merge them later. or let sparc64 to use lmb_find_area_node()?

YH
 
