From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 03/25] lmb: Print new doubled array location info
Date: Tue, 29 Jun 2010 13:03:21 -0700
Message-ID: <4C2A5189.60508@kernel.org>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org> <1277227614-11581-4-git-send-email-yinghai@kernel.org> <201006291144.14469.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:63322 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958Ab0F2UGr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jun 2010 16:06:47 -0400
In-Reply-To: <201006291144.14469.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 06/29/2010 10:44 AM, Bjorn Helgaas wrote:
> On Tuesday, June 22, 2010 11:26:32 am Yinghai Lu wrote:
>> +	if (lmb_debug)
>> +		pr_info("lmb: %s array is doubled to %ld at %llx - %llx",
>> +			 lmb_type_name(type), type->max * 2, (u64)addr, (u64)addr + new_size);
> 
> Please print this memory range the same way we print resources, e.g.,
> "%#010llx-%#010llx", with "addr" and "addr + new_size - 1".

ok, I will put # for 0x.

but i like to have

xxx - yyy : to include end
[xxx, yyy - 1]

just like current e820 print out.
and it would be more readable without too many ffff

Thanks

Yinghai
