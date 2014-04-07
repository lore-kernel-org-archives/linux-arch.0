Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:52222 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbaDGRqt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Apr 2014 13:46:49 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <raghavendra.kt@linux.vnet.ibm.com>;
	Tue, 8 Apr 2014 03:46:46 +1000
Message-ID: <5342E5B2.1070306@linux.vnet.ibm.com>
Date: Mon, 07 Apr 2014 23:21:46 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 00/10] qspinlock: a 4-byte queue spinlock with PV support
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com> <5342425A.7040005@linux.vnet.ibm.com> <5342D475.7060503@hp.com>
In-Reply-To: <5342D475.7060503@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140407175146.QcXzca1tFRpftEws08iuRzi7GW6zUyQpBiVm0l3L_hQ@z>

On 04/07/2014 10:08 PM, Waiman Long wrote:
> On 04/07/2014 02:14 AM, Raghavendra K T wrote:
[...]
>> But I am seeing hang in overcommit cases. Gdb showed that many vcpus
>> are halted and there was no progress. Suspecting the problem /race with
>> halting, I removed the halt() part of kvm_hibernate().  I am yet to
>> take a closer look at the code on halt() related changes.
>
> It seems like there may still be race conditions where the current code
> is not handling correctly. I will look into that to see where the
> problem is. BTW, what test do you use to produce the hang condition?

Running ebizzy on 2 of the vms simultaneously (for sometime in repeated 
loop) could reproduce it.

>> Patch series with that change gave around 20% improvement for dbench
>> 2x and 30% improvement for ebizzy 2x cases. (1x has no significant
>> loss/gain).
>>

While at it, Just  a correction it was 30% for  ebizzy1.5x  and around
80% for ebizzy 2x.

> What is the baseline for the performance improvement? Is it without the
> unfair lock and PV qspinlock?

Baseline was 3.14-rc8 without any of the qspin patch series.

