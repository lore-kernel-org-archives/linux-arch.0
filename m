From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [RFC PATCH 6/6] sparc64: use early_res and nobootmem
Date: Wed, 10 Mar 2010 16:02:07 -0800
Message-ID: <4B9832FF.9010004@kernel.org>
References: <4B9818CE.7090809@kernel.org>	 <20100310.141757.95833226.davem@davemloft.net>	 <4B981DBD.2060303@kernel.org>	 <20100310.143602.266086944.davem@davemloft.net> <1268264837.22204.688.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59372 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932905Ab0CKADw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 19:03:52 -0500
In-Reply-To: <1268264837.22204.688.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/10/2010 03:47 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2010-03-10 at 14:36 -0800, David Miller wrote:
>> LMB could do this too with minor modifications.
>>
>> Simply make the lmb.memory and lmb.reserved be pointers, and initially
>> they point into the static array(s).
>>
>> Later the pointers can be repositioned to point to dynamically
>> allocated memory.
>>
>> So please, for the third time, please show me how LMB with some minor
>> modifications is not able to satisfy your needs. 
> 
> So I was about to say the exact same stuff here...
> 
let see:
1. if early_res + fw_memmap could be simplified...
2. or let x86 to use lmb instead of early_res,then add more to lmb.

YH
