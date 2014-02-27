From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v5 7/8] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Thu, 27 Feb 2014 14:42:34 -0500
Message-ID: <530F952A.3030702@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-8-git-send-email-Waiman.Long@hp.com>
	<530F2B8F.1010401@citrix.com> <530F3967.6030805@redhat.com>
	<530F4949.4050706@citrix.com> <530F4F98.2080308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F4F98.2080308@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/27/2014 09:45 AM, Paolo Bonzini wrote:
> Il 27/02/2014 15:18, David Vrabel ha scritto:
>> On 27/02/14 13:11, Paolo Bonzini wrote:
>>> Il 27/02/2014 13:11, David Vrabel ha scritto:
>>>>>> This patch adds para-virtualization support to the queue spinlock 
>>>>>> code
>>>>>> by enabling the queue head to kick the lock holder CPU, if known,
>>>>>> in when the lock isn't released for a certain amount of time. It
>>>>>> also enables the mutual monitoring of the queue head CPU and the
>>>>>> following node CPU in the queue to make sure that their CPUs will
>>>>>> stay scheduled in.
>>>> I'm not really understanding how this is supposed to work.  There
>>>> appears to be an assumption that a guest can keep one of its VCPUs
>>>> running by repeatedly kicking it?  This is not possible under Xen 
>>>> and I
>>>> doubt it's possible under KVM or any other hypervisor.
>>>
>>> KVM allows any VCPU to wake up a currently halted VCPU of its choice,
>>> see Documentation/virtual/kvm/hypercalls.txt.
>>
>> But neither of the VCPUs being kicked here are halted -- they're either
>> running or runnable (descheduled by the hypervisor).
>
> /me actually looks at Waiman's code...
>
> Right, this is really different from pvticketlocks, where the *unlock* 
> primitive wakes up a sleeping VCPU.  It is more similar to PLE 
> (pause-loop exiting).
>
> Paolo

Yes, it is mostly to deal with vCPU that are not running because of PLE.

-Longman
