From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [RFC PATCH v2 20/25] smp, tile: kill SMP single function call
 interrupt
Date: Wed, 11 Sep 2013 12:51:44 -0400
Message-ID: <52309FA0.4030706@tilera.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com> <1378915649-16395-21-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:21648 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3IKQw1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Sep 2013 12:52:27 -0400
In-Reply-To: <1378915649-16395-21-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 9/11/2013 12:07 PM, Jiang Liu wrote:
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

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
