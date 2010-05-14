From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 13/35] x86, lmb: Add lmb_free_memory_size()
Date: Sat, 15 May 2010 08:20:35 +1000
Message-ID: <1273875635.21352.638.camel@pasglop>
References: <1273796396-29649-1-git-send-email-yinghai@kernel.org>
	 <1273796396-29649-14-git-send-email-yinghai@kernel.org>
	 <1273804285.21352.392.camel@pasglop>  <4BECF0E2.90406@oracle.com>
	 <1273825287.21352.592.camel@pasglop>  <4BED7C34.1060200@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59032 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab0ENWWT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 May 2010 18:22:19 -0400
In-Reply-To: <4BED7C34.1060200@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai.lu@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, 2010-05-14 at 09:37 -0700, Yinghai Lu wrote:
> 
> lmb_memory_size_in_range()/lmb_free_memory_size_in_range()
> 
> or
> 
> lmb_memory_in_range()/lmb_free_memory_in_range() 

I think the "size" is unnecessary, go for the second.

Cheers,
Ben.
