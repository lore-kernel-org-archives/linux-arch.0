From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH RFC v5 7/8] pvqspinlock, x86: Add qspinlock
	para-virtualization support
Date: Mon, 3 Mar 2014 11:06:52 +0000
Message-ID: <5314624C.8020003@citrix.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>	<1393427668-60228-8-git-send-email-Waiman.Long@hp.com>	<530F2B8F.1010401@citrix.com>
	<530F3967.6030805@redhat.com>	<530F4949.4050706@citrix.com>
	<530F4F98.2080308@redhat.com>	<530F5851.1090809@linux.vnet.ibm.com>
	<530F5EC7.4060603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F5EC7.4060603@redhat.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Daniel J Blueman <daniel@numascale.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vino>
List-Id: linux-arch.vger.kernel.org

On 27/02/14 15:50, Paolo Bonzini wrote:
> Il 27/02/2014 16:22, Raghavendra K T ha scritto:
>> On 02/27/2014 08:15 PM, Paolo Bonzini wrote:
>> [...]
>>>> But neither of the VCPUs being kicked here are halted -- they're either
>>>> running or runnable (descheduled by the hypervisor).
>>>
>>> /me actually looks at Waiman's code...
>>>
>>> Right, this is really different from pvticketlocks, where the *unlock*
>>> primitive wakes up a sleeping VCPU.  It is more similar to PLE
>>> (pause-loop exiting).
>>
>> Adding to the discussion, I see there are two possibilities here,
>> considering that in undercommit cases we should not exceed
>> HEAD_SPIN_THRESHOLD,
>>
>> 1. the looping vcpu in pv_head_spin_check() should do halt()
>> considering that we have done enough spinning (more than typical
>> lock-hold time), and hence we are in potential overcommit.
>>
>> 2. multiplex kick_cpu to do directed yield in qspinlock case.
>> But this may result in some ping ponging?
> 
> Actually, I think the qspinlock can work roughly the same as the
> pvticketlock, using the same lock_spinning and unlock_lock hooks.

This is is approach I would like to see.  This would also work for Xen
PV guests.

The current implementation depends on hardware PLE which Xen PV guests
do not support and I'm not sure if other architectures have something
similar (e.g., does ARM's virtualization extensions have PLE?).

David
