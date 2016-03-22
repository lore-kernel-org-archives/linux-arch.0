From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Tue, 22 Mar 2016 18:30:05 +0100
Message-ID: <20160322173005.GT6344@twins.programming.kicks-ass.net>
References: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com>
 <1458667179-19630-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59454 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbcCVRaK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2016 13:30:10 -0400
Content-Disposition: inline
In-Reply-To: <1458667179-19630-5-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Mar 22, 2016 at 01:19:39PM -0400, Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> 
> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> This commit suitably tags x86, arm64, and tile idle routines,
> and only adds in the minimal framework for other architectures.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>

For some reason I found a few CPUs using poll_idle().

Rafael, when and why would that ever get selected as a useful idle
state? When the predicted idle time is so short even C1 isn't worth it?


--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -14,6 +14,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/tick.h>
+#include <linux/cpu.h>
 
 #include "cpuidle.h"
 
@@ -178,7 +179,7 @@ static void __cpuidle_driver_init(struct
 }
 
 #ifdef CONFIG_ARCH_HAS_CPU_RELAX
-static int poll_idle(struct cpuidle_device *dev,
+__cpuidle static int poll_idle(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	local_irq_enable();
