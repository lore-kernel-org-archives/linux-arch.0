Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40833 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbaENTGY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 May 2014 15:06:24 -0400
Message-ID: <5373BE81.90208@redhat.com>
Date: Wed, 14 May 2014 15:05:37 -0400
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 04/27] alpha: Use generic tlb.h
References: <1400093999-18703-1-git-send-email-richard@nod.at> <1400093999-18703-5-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-5-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, linux-alpha@vger.kernel.org
Message-ID: <20140514190537.lMseF3PlHCbapX-cATQMhn4OR7raH5SyM_-ihGooqw8@z>

On 05/14/2014 02:59 PM, Richard Weinberger wrote:
> As everything we need is now in generic tlb.h
> we can drop our own one.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Rik van Riel <riel@redhat.com>


-- 
All rights reversed
