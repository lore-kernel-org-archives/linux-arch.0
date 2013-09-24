From: Christoph Lameter <cl@linux.com>
Subject: [pchecks v2 0/2] percpu v2: Implement Preemption checks for __this_cpu operations
Date: Tue, 24 Sep 2013 15:41:41 +0000
Message-ID: <0000014150a21162-f0f1d0c6-9686-4360-b32b-a04c48f33c51-000000@email.amazonses.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a14-70.smtp-out.amazonses.com ([54.240.14.70]:32867 "EHLO
	a14-70.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751096Ab3IXQA7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Sep 2013 12:00:59 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>

This patchset introduces preemption checks for __this_cpu operations.

First we add new raw_cpu operations that perform this cpu operations
without preempt checks. 

The second patch then adds the preempt checks by modifying the
__this_cpu macros in include/linux/percpu.h

V1->V2:
	- Reuse preemption check logic in lib/smp_processor_id.c
	- Add CONFIG_DEBUG_THIS_CPU_OPERATIONS
	- Remove conversions to the use of raw_cpu_ops since
	  these may require some discussion first.
