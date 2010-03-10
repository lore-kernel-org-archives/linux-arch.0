From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 6/6] sparc64: use early_res and nobootmem
Date: Wed, 10 Mar 2010 14:36:02 -0800 (PST)
Message-ID: <20100310.143602.266086944.davem@davemloft.net>
References: <4B9818CE.7090809@kernel.org>
	<20100310.141757.95833226.davem@davemloft.net>
	<4B981DBD.2060303@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60998
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757370Ab0CJWfm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 17:35:42 -0500
In-Reply-To: <4B981DBD.2060303@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yinghai@kernel.org
Cc: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 10 Mar 2010 14:31:25 -0800

> they are array based.
> 
> 1. memmap is not changed after get it from firmware, <could be modified via mem= or memmap=>
> 2. early_res at first is static array, later it will be relocated to another position if the array is not big enough.

LMB could do this too with minor modifications.

Simply make the lmb.memory and lmb.reserved be pointers, and initially
they point into the static array(s).

Later the pointers can be repositioned to point to dynamically
allocated memory.

So please, for the third time, please show me how LMB with some minor
modifications is not able to satisfy your needs.
