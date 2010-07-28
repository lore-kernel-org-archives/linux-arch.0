From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 31/31] memblock: Add memblock_find_in_range()
Date: Wed, 28 Jul 2010 09:06:03 -0700
Message-ID: <4C50556B.6020301@zytor.com>
References: <1279822864-17154-1-git-send-email-yinghai@kernel.org>	 <1279822864-17154-32-git-send-email-yinghai@kernel.org> <1280295415.1970.245.camel@pasglop> <4C4FC95F.6040806@kernel.org> <4C4FD04B.5090503@zytor.com> <4C4FD85C.2090603@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51593 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab0G1QGy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Jul 2010 12:06:54 -0400
In-Reply-To: <4C4FD85C.2090603@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 07/28/2010 12:12 AM, Yinghai Lu wrote:
> 
> the problem is later if the user hit the problem, it will be called "Regression" after bisecting to the memblock/x86 changes.
> because low/high does work before.
> 
> BTW, that design from qlogic to save log in RAM is not good one, they may save some cents for the ram in card.
> 
> other vendors seems put log/trace in the ram on card.
> 

It's broken NOW.  The only reason it's not exploding is by accident.
The fact that you knew about the problem and had the notion of working
around it instead of fixing the root cause by either fixing or
blacklisting the broken driver is disgusting beyond belief.

Either the driver needs to map the memory off limit in the e820 map
passed to kexec, or better yet it should have its DMA disabled across
kexec.  I'm truly appalled.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
