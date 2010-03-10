From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 6/6] sparc64: use early_res and nobootmem
Date: Wed, 10 Mar 2010 14:17:57 -0800 (PST)
Message-ID: <20100310.141757.95833226.davem@davemloft.net>
References: <4B981049.3040607@kernel.org>
	<20100310.133646.144946890.davem@davemloft.net>
	<4B9818CE.7090809@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43343
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169Ab0CJWRi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 17:17:38 -0500
In-Reply-To: <4B9818CE.7090809@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yinghai@kernel.org
Cc: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 10 Mar 2010 14:10:22 -0800

> On 03/10/2010 01:36 PM, David Miller wrote:
>> And LMB cannot fill this void with some minor modifications?
> 
> early_res array could be increased automatically...
> 
> could be something like:
> keep lmb.memory part, and use early_res for reserved parts...

LMB has a reserved region.

I still have yet to see any fundamental reason why LMB
cannot, all by itself, be used to solve this problem too.
