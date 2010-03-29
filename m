From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 20/31] lmb: Add __NOT_KEEP_LMB to put lmb code to .init
Date: Mon, 29 Mar 2010 12:11:39 -0700 (PDT)
Message-ID: <20100329.121139.233095272.davem@davemloft.net>
References: <4BB0D34C.7060509@kernel.org>
	<20100329.113449.174804111.davem@davemloft.net>
	<4BB0F3F8.3090304@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36886
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752320Ab0C2TLi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Mar 2010 15:11:38 -0400
In-Reply-To: <4BB0F3F8.3090304@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yinghai@kernel.org
Cc: michael@ellerman.id.au, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, benh@kernel.crashing.org, torvalds@linux-foundation.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Mon, 29 Mar 2010 11:39:52 -0700

> On 03/29/2010 11:34 AM, David Miller wrote:
>> From: Yinghai Lu <yinghai@kernel.org>
>> Date: Mon, 29 Mar 2010 09:20:28 -0700
>> 
>>> BTW, it seems only PowerPC need to keep lmb after init stage, right ?
>> 
>> For now.  Sparc64 will need it at some point in the future.
> 
> for memory hotplug support?

Yes.
