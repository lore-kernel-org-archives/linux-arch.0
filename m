From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Wed, 8 Feb 2017 15:17:45 -0500
Message-ID: <2bad716f-8e78-d9c0-56c9-61f5d52ab97a@redhat.com>
References: <1486576825-17058-1-git-send-email-longman@redhat.com>
	<20170208190508.GA6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170208190508.GA6515@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/08/2017 02:05 PM, Peter Zijlstra wrote:
> On Wed, Feb 08, 2017 at 01:00:24PM -0500, Waiman Long wrote:
>> It was found when running fio sequential write test with a XFS ramdisk
>> on a 2-socket x86-64 system, the %CPU times as reported by perf were
>> as follows:
>>
>>  71.27%  0.28%  fio  [k] down_write
>>  70.99%  0.01%  fio  [k] call_rwsem_down_write_failed
>>  69.43%  1.18%  fio  [k] rwsem_down_write_failed
>>  65.51% 54.57%  fio  [k] osq_lock
>>   9.72%  7.99%  fio  [k] __raw_callee_save___kvm_vcpu_is_preempted
>>   4.16%  4.16%  fio  [k] __kvm_vcpu_is_preempted
>>
>> So making vcpu_is_preempted() a callee-save function has a pretty high
>> cost associated with it. As vcpu_is_preempted() is called within the
>> spinlock, mutex and rwsem slowpaths, there isn't much to gain by making
>> it callee-save. So it is now changed to a normal function call instead.
>>
> Numbers for bare metal too please.

I will run the test on bare metal, but I doubt there will be noticeable
difference.

Cheers,
Longman
