From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH v2 03/25] smp, ARC: kill SMP single function call
 interrupt
Date: Wed, 25 Sep 2013 17:01:41 +0530
Message-ID: <5242C99D.2010401@synopsys.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com> <1378915649-16395-4-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:63755 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab3IYLeP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Sep 2013 07:34:15 -0400
In-Reply-To: <1378915649-16395-4-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Shaohua Li <shli@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Noam Camus <noamc@ezchip.com>, Gilad Ben Yossef <giladb@ezchip.com>

On 09/11/2013 09:37 PM, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one interrupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Jiang Liu <liuj97@gmail.com>

Verified that it works for ARC too.

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
