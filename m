From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/4] [RFC] mcount address adjustment
Date: Tue, 10 May 2011 10:10:39 +0200
Message-ID: <20110510081039.241831019@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:44859 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab1EJILD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2011 04:11:03 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4A8AtRH020345
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 08:10:55 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4A8Attb2244692
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 09:10:55 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4A8AsZX014557
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 09:10:55 +0100
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, H.

This series of patches aims to simplify the mcount address adjustment for
ftrace. The frace code wants to know the start address of each function,
not the address of the relocation against the mcount symbol which have
been recorded to the __mcount_loc section. The ftrace_call_adjust function
is used to calculate the start address of the function from the mcount
relocation at runtime.

For x86, ia64 and s390 the adjustment is a constant offset. There is no
need to do the adjustment at runtime, it can be done by recordmcount at
compile time. Blackfin already does this with the mcount_adjust variable
in the pearl version of recordmcount. After teaching the C version of
recordmcount about mcount_adjust x86, ia64 and s390 can be converted to
a nop ftrace_call_adjust function.

That leaves arm as the last remaining architecture with a non trivial
ftrace_call_adjust function. There the least significant bit is removed
from the address with an and operation. The comment says this is done
for Thumb-2. This implies that for Thumb-1 the offset is 0 and for
Thumb-2 the offset is -1, correct? If there is a way to distinguish
the two targets in recordmcount at compile time we could convert arm
as well. Which would allow us to remove the ftrace_call_adjust function.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
