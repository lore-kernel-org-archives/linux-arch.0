From: Yinghai <yinghai.lu@oracle.com>
Subject: Re: [PATCH 07/22] lmb: Add lmb_to_bootmem()
Date: Sun, 09 May 2010 21:31:51 -0700
Message-ID: <4BE78C37.5080103@oracle.com>
References: <1273331860-14325-1-git-send-email-yinghai@kernel.org>	 <1273331860-14325-8-git-send-email-yinghai@kernel.org> <1273461193.23699.9.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:27247 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab0EJEeT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2010 00:34:19 -0400
In-Reply-To: <1273461193.23699.9.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 05/09/2010 08:13 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2010-05-08 at 08:17 -0700, Yinghai Lu wrote:
>> lmb_to_bootmem() will reserve lmb.reserved.region in bootmem after bootmem is
>> set up.
>>
>> We can use it to with all arches that support lmb later.
> 
> This is clumsy. Doesn't work with NUMA either. Also,

it works NUMA. for x86 we managed to call that one time from 2.6.34-rc1. (still called early_res_to_bootmem().
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1842f90cc98625d4d9bf8f8b927f17705ceb4e9c

> reserve_bootmem_generic() only exists on x86 afaik.

previous patch add weak version 
[PATCH 06/22] bootmem, x86: Add weak version of reserve_bootmem_generic

YH
