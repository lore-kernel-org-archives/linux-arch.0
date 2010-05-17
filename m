From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 01/35] lmb: prepare x86 to use lmb to replace early_res
Date: Mon, 17 May 2010 11:03:44 -0700
Message-ID: <4BF18500.60105@zytor.com>
References: <1273796396-29649-1-git-send-email-yinghai@kernel.org>	 <1273796396-29649-2-git-send-email-yinghai@kernel.org>	 <1273803143.21352.353.camel@pasglop>  <4BECEB8D.8070600@oracle.com> <1273824578.21352.579.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:46160 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab0EQSK1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2010 14:10:27 -0400
In-Reply-To: <1273824578.21352.579.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai <yinghai.lu@oracle.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 05/14/2010 01:09 AM, Benjamin Herrenschmidt wrote:
> 
> No. That is not the point. Read the rest of my email !
> 
> We need to -sanitize- those errors. _Maybe_ exposing LMB_ERROR is the
> right way to do so, but in that case, we need to make -all- function use
> the same error code. Right now, some fail with 0 and some with
> LMB_ERROR.
> 

Using errnos like the rest of the kernel seems like the right thing to
do, IMO.

	-hpa
