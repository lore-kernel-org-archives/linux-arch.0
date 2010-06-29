From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 03/25] lmb: Print new doubled array location info
Date: Tue, 29 Jun 2010 11:38:44 -0700
Message-ID: <4C2A3DB4.70308@zytor.com>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org> <1277227614-11581-4-git-send-email-yinghai@kernel.org> <201006291144.14469.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33258 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab0F2Sjf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Jun 2010 14:39:35 -0400
In-Reply-To: <201006291144.14469.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 06/29/2010 10:44 AM, Bjorn Helgaas wrote:
> On Tuesday, June 22, 2010 11:26:32 am Yinghai Lu wrote:
>> +	if (lmb_debug)
>> +		pr_info("lmb: %s array is doubled to %ld at %llx - %llx",
>> +			 lmb_type_name(type), type->max * 2, (u64)addr, (u64)addr + new_size);
> 
> Please print this memory range the same way we print resources, e.g.,
> "%#010llx-%#010llx", with "addr" and "addr + new_size - 1".

*Ten* hex digits?

	-hpa
