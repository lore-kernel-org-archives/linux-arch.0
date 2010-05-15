From: Yinghai <yinghai.lu@oracle.com>
Subject: Re: [PATCH 07/37] lmb: Add lmb_find_area()
Date: Fri, 14 May 2010 17:11:16 -0700
Message-ID: <4BEDE6A4.4050505@oracle.com>
References: <1273866363-14249-1-git-send-email-yinghai@kernel.org>	 <1273866363-14249-8-git-send-email-yinghai@kernel.org> <1273876749.21352.645.camel@pasglop> <4BEDD7D4.90002@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:52108 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab0EOANF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2010 20:13:05 -0400
In-Reply-To: <4BEDD7D4.90002@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 05/14/2010 04:08 PM, Yinghai wrote:
> On 05/14/2010 03:39 PM, Benjamin Herrenschmidt wrote:
>>
>> I might have accepted that one if you had called it something like
>> lmb_find_in_range() which at least -means- something.
> 
> thanks. will use sed to replace them.
> 
> lmb_find_area ==> lmb_find_in_range()
> 

updated version is in

	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-2.6-yinghai.git lmb

it is on top of tip/master + powerpc/lmb

Thanks

Yinghai
