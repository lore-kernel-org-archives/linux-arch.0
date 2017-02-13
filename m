From: hpa@zytor.com
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Mon, 13 Feb 2017 14:36:36 -0800
Message-ID: <3A7771CA-4B1F-4BBD-9CB0-08680EFB2D11@zytor.com>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
	<20170210161928.GI6515@twins.programming.kicks-ass.net>
	<1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
	<14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
	<20170213104716.GM6515@twins.programming.kicks-ass.net>
	<20170213105343.GJ6536@twins.programming.kicks-ass.net>
	<3dc50409-60dd-ad47-f971-448191e66038@redhat.com>
	<6f69b112-7ae4-bf8f-b767-29a68fd48632@redhat.com>
	<20170213215220.GN25813@worktop.programming.kicks-ass.net>
	<933ba8c6-4ebe-63e2-3c3a-2e5afef9269a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <933ba8c6-4ebe-63e2-3c3a-2e5afef9269a@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On February 13, 2017 2:34:01 PM PST, Waiman Long <longman@redhat.com> wrote:
>On 02/13/2017 04:52 PM, Peter Zijlstra wrote:
>> On Mon, Feb 13, 2017 at 03:12:45PM -0500, Waiman Long wrote:
>>> On 02/13/2017 02:42 PM, Waiman Long wrote:
>>>> On 02/13/2017 05:53 AM, Peter Zijlstra wrote:
>>>>> On Mon, Feb 13, 2017 at 11:47:16AM +0100, Peter Zijlstra wrote:
>>>>>> That way we'd end up with something like:
>>>>>>
>>>>>> asm("
>>>>>> push %rdi;
>>>>>> movslq %edi, %rdi;
>>>>>> movq __per_cpu_offset(,%rdi,8), %rax;
>>>>>> cmpb $0, %[offset](%rax);
>>>>>> setne %al;
>>>>>> pop %rdi;
>>>>>> " : : [offset] "i" (((unsigned long)&steal_time) +
>offsetof(struct steal_time, preempted)));
>>>>>>
>>>>>> And if we could get rid of the sign extend on edi we could avoid
>all the
>>>>>> push-pop nonsense, but I'm not sure I see how to do that (then
>again,
>>>>>> this asm foo isn't my strongest point).
>>>>> Maybe:
>>>>>
>>>>> movsql %edi, %rax;
>>>>> movq __per_cpu_offset(,%rax,8), %rax;
>>>>> cmpb $0, %[offset](%rax);
>>>>> setne %al;
>>>>>
>>>>> ?
>>>> Yes, that looks good to me.
>>>>
>>>> Cheers,
>>>> Longman
>>>>
>>> Sorry, I am going to take it back. The displacement or offset can
>only
>>> be up to 32-bit. So we will still need to use at least one more
>>> register, I think.
>> I don't think that would be a problem, I very much doubt we declare
>more
>> than 4G worth of per-cpu variables in the kernel.
>>
>> In any case, use "e" or "Z" as constraint (I never quite know when to
>> use which). That are s32 and u32 displacement immediates resp. and
>> should fail compile with a semi-sensible failure if the displacement
>is
>> too big.
>>
>It is the address of &steal_time that will exceed the 32-bit limit.
>
>Cheers,
>Longman

That seems odd in the extreme?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
