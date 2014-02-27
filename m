From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC v5 7/8] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Thu, 27 Feb 2014 14:11:03 +0100
Message-ID: <530F3967.6030805@redhat.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-8-git-send-email-Waiman.Long@hp.com>
	<530F2B8F.1010401@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F2B8F.1010401@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>, Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

Il 27/02/2014 13:11, David Vrabel ha scritto:
>> > This patch adds para-virtualization support to the queue spinlock code
>> > by enabling the queue head to kick the lock holder CPU, if known,
>> > in when the lock isn't released for a certain amount of time. It
>> > also enables the mutual monitoring of the queue head CPU and the
>> > following node CPU in the queue to make sure that their CPUs will
>> > stay scheduled in.
> I'm not really understanding how this is supposed to work.  There
> appears to be an assumption that a guest can keep one of its VCPUs
> running by repeatedly kicking it?  This is not possible under Xen and I
> doubt it's possible under KVM or any other hypervisor.

KVM allows any VCPU to wake up a currently halted VCPU of its choice, 
see Documentation/virtual/kvm/hypercalls.txt.

   5. KVM_HC_KICK_CPU
   ------------------------
   Architecture: x86
   Status: active
   Purpose: Hypercall used to wakeup a vcpu from HLT state
   Usage example : A vcpu of a paravirtualized guest that is busywaiting
   in guest kernel mode for an event to occur (ex: a spinlock to become
   available) can execute HLT instruction once it has busy-waited for more
   than a threshold time-interval. Execution of HLT instruction would cause
   the hypervisor to put the vcpu to sleep until occurrence of an 
appropriate
   event. Another vcpu of the same guest can wakeup the sleeping vcpu by
   issuing KVM_HC_KICK_CPU hypercall, specifying APIC ID (a1) of the vcpu
   to be woken up. An additional argument (a0) is used in the hypercall for
   future use.

This is the same as a dummy IPI, but cheaper (about 2000 clock cycles 
wasted on the source VCPU, and the latency on the destination is about 
half; an IPI costs roughly the same on the source and much more on the 
destination).

It looks like Xen could use an event channel.

Paolo
