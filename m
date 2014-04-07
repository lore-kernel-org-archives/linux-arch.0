From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 00/10] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Mon, 07 Apr 2014 23:21:46 +0530
Message-ID: <5342E5B2.1070306@linux.vnet.ibm.com>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
	<5342425A.7040005@linux.vnet.ibm.com> <5342D475.7060503@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5342D475.7060503@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>
List-Id: linux-arch.vger.kernel.org

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
