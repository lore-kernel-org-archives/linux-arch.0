From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [RFC PATCH v3 17/19] smp, tile: kill SMP single function call
 interrupt
Date: Thu, 5 Dec 2013 16:08:59 -0500
Message-ID: <52A0EB6B.9010205@tilera.com>
References: <1386173591-28514-1-git-send-email-liuj97@gmail.com> <1386173591-28514-18-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:61530 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab3LEVJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2013 16:09:00 -0500
In-Reply-To: <1386173591-28514-18-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Tony Lu <zlu@tilera.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-arch@vger.kernel.org

On 12/4/2013 11:13 AM, Jiang Liu wrote:
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one intterupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jiri Kosina <trivial@kernel.org>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/tile/include/asm/smp.h | 7 +++----
>  arch/tile/kernel/smp.c      | 6 +-----
>  2 files changed, 4 insertions(+), 9 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
