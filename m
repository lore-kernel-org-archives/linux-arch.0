From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 07/39] lmb: Add lmb_find_area()
Date: Tue, 13 Apr 2010 20:15:09 +1000
Message-ID: <1271153709.13059.101.camel@pasglop>
References: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
	 <1270793048-23796-8-git-send-email-yinghai@kernel.org>
	 <1271131543.13059.53.camel@pasglop>  <4BC3F317.7030702@oracle.com>
	 <1271135239.13059.69.camel@pasglop> <4BC40074.6030604@oracle.com>
	 <4BC4053D.2050805@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36022 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab0DMKQl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Apr 2010 06:16:41 -0400
In-Reply-To: <4BC4053D.2050805@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai <yinghai.lu@oracle.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, 2010-04-12 at 22:46 -0700, H. Peter Anvin wrote:
> On 04/12/2010 10:26 PM, Yinghai wrote:
> > 
> > current generic lmb_find_area() is allocating from high to low.
> > x86 32bit seems have problem with that.
> 
> Presumably because it fills up ZONE_DMA.

I'm working on some LMB cleanups now, among others trying to take into
account what I think are Yinghai requirements. Give me a few days.

For the specific problem above, my idea is to have the low level alloc
function be able to take both low and high limits, so that x86 can
figure out what's best for a given allocation.

Cheers,
Ben.
