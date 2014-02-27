From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v5 7/8] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Thu, 27 Feb 2014 15:50:37 -0500
Message-ID: <530FA51D.6060303@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-8-git-send-email-Waiman.Long@hp.com>
	<530F2B8F.1010401@citrix.com> <530F3967.6030805@redhat.com>
	<530F4949.4050706@citrix.com> <530F4F98.2080308@redhat.com>
	<530F5851.1090809@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F5851.1090809@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu
List-Id: linux-arch.vger.kernel.org

On 02/27/2014 10:22 AM, Raghavendra K T wrote:
> On 02/27/2014 08:15 PM, Paolo Bonzini wrote:
> [...]
>>> But neither of the VCPUs being kicked here are halted -- they're either
>>> running or runnable (descheduled by the hypervisor).
>>
>> /me actually looks at Waiman's code...
>>
>> Right, this is really different from pvticketlocks, where the *unlock*
>> primitive wakes up a sleeping VCPU.  It is more similar to PLE
>> (pause-loop exiting).
>
> Adding to the discussion, I see there are two possibilities here,
> considering that in undercommit cases we should not exceed
> HEAD_SPIN_THRESHOLD,
>
> 1. the looping vcpu in pv_head_spin_check() should do halt()
> considering that we have done enough spinning (more than typical
> lock-hold time), and hence we are in potential overcommit.
>
> 2. multiplex kick_cpu to do directed yield in qspinlock case.
> But this may result in some ping ponging?
>
>
>

In the current code, the lock holder can't easily locate the CPU # of 
the queue head when in the unlock path. That is why I try to keep the 
queue head alive as long as possible so that it can take over when the 
lock is free. I am trying out new code to let the CPUs that are waiting 
other than the first 2 to go to halt to see if that will help the 
overcommit case.

-Longman
