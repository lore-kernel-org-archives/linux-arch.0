Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21033 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab0HTVtI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2010 17:49:08 -0400
Message-ID: <4C6EF82C.2090703@redhat.com>
Date: Fri, 20 Aug 2010 17:48:28 -0400
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 3/6] mm, frv: Out-of-line kmap-atomic
References: <20100819201317.673172547@chello.nl> <20100819202753.710621383@chello.nl>
In-Reply-To: <20100819202753.710621383@chello.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20100820214828.JowECrllQt1p0MEStirO_G6E2NuAuQmliZrY6LOLy7U@z>

On 08/19/2010 04:13 PM, Peter Zijlstra wrote:
> Out-of-line the kmap_atomic implementation since the dynamic type
> destroys all the constant value reduction previously used.
>
> Also, remove the first 4 primary maps, since those are used by the
> architecture for special purposes, mostly through direct assembly, but
> also through the __kmap_atomic_primary() interface.
>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
