From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 02/31] x86: Make sure free_init_pages() free pages in
 boundary
Date: Mon, 29 Mar 2010 09:59:10 -0700
Message-ID: <4BB0DC5E.1040404@kernel.org>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org> <1269830604-26214-3-git-send-email-yinghai@kernel.org> <20100329165706.GA13961@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41520 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab0C2RBj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Mar 2010 13:01:39 -0400
In-Reply-To: <20100329165706.GA13961@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/29/2010 09:57 AM, Ingo Molnar wrote:
> 
> Note, i applied the fix below, without it the 32-bit defconfig build would 
> fail with:
> 
>  arch/x86/kernel/head32.c: In function 'i386_start_kernel':
>  arch/x86/kernel/head32.c:50: error: implicit declaration of function 'PAGE_ALIGN'
> 
thanks.

after lmb work, will check all those
round_up
round_down
roundup
PAGE_ALIGN
ALIGN
...

We promised to Andrew, We need to clean them up.


Yinghai
