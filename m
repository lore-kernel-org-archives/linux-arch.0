From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 03/23] lmb: Print new doubled array location info
Date: Thu, 08 Jul 2010 13:07:38 -0700
Message-ID: <4C36300A.7030606@kernel.org>
References: <1278226587-31213-1-git-send-email-yinghai@kernel.org> <1278226587-31213-4-git-send-email-yinghai@kernel.org> <201007081255.58049.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:52831 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab0GHUMI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2010 16:12:08 -0400
In-Reply-To: <201007081255.58049.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 07/08/2010 11:55 AM, Bjorn Helgaas wrote:
> On Sunday, July 04, 2010 12:56:07 am Yinghai Lu wrote:
>> -		pr_info(" %s[0x%x]\t0x%016llx - 0x%016llx, 0x%llx bytes\n",
>> -		    name, i, base, base + size - 1, size);
>> +		pr_info(" %s[%#x]\t[%#016llx - %#016llx], %#llx bytes\n",
>> +		    name, i, base, base + size, size);
> 
> I know you think it's prettier to have zeroes and extra spaces like this:
> 
>   [0xe7000000 - 0xe8000000, 0x1000000 bytes]
> 
> rather than a bunch of 'F's:
> 
>   [0xe7000000-0xe7ffffff]
> 
> But for the record, I still think you're wrong and that it's better
> to be consistent even if it's slightly uglier.  The inconsistencies
> lead to confusion and off-by-one errors.

We can make them to be consistent later.

current for early mem stage, it is consistent to without -1.

later I like to see all pci resource could be consistent to without -1 too.

Thanks

Yinghai
