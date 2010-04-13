From: Yinghai <yinghai.lu@oracle.com>
Subject: Re: [PATCH 06/39] lmb: Seperate __lmb_find_base() from __lmb_alloc_base()
Date: Mon, 12 Apr 2010 21:31:45 -0700
Message-ID: <4BC3F3B1.9020000@oracle.com>
References: <1270793048-23796-1-git-send-email-yinghai@kernel.org>	 <1270793048-23796-7-git-send-email-yinghai@kernel.org> <1271131081.13059.51.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:29120 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab0DMEda (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2010 00:33:30 -0400
In-Reply-To: <1271131081.13059.51.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 04/12/2010 08:58 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-04-08 at 23:03 -0700, Yinghai Lu wrote:
> 
>> +	return -1ULL;
>> +}
> 
> Defininf some kind of LMB_ERROR would be nicer.

ok, also __lmb_alloc_base could return 0 when fail to get one.

replace that 0 with LMB_ERROR aka -1ULL?

Yinghai
