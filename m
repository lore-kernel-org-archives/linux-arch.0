From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC v5 4/8] pvqspinlock, x86: Allow unfair spinlock in
	a real PV environment
Date: Tue, 04 Mar 2014 16:23:16 +0100
Message-ID: <5315EFE4.6090503@redhat.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-5-git-send-email-Waiman.Long@hp.com>
	<20140226170734.GB20775@phenom.dumpdata.com>
	<5310C21F.7000809@hp.com> <53145FAD.3020905@redhat.com>
	<5315EE2E.2060002@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5315EE2E.2060002@hp.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

Il 04/03/2014 16:15, Waiman Long ha scritto:
>>
>> PLE is unnecessary if you have "true" pv spinlocks where the
>> next-in-line schedules itself out with a hypercall (Xen) or hlt
>> instruction (KVM).  Set a bit in the qspinlock before going to sleep,
>> and the lock owner will know that it needs to kick the next-in-line.
>>
>> I think there is no need for the unfair lock bits.  1-2% is a pretty
>> large hit.
>
> I don't think that PLE is something that can be controlled by software.
> It is done in hardware.

Yes, but the hypervisor decides *what* to do when the processor detects 
a pause-loop.

But my point is that if you have pv spinlocks, the processor in the end 
will never or almost never do a pause-loop exit.  PLE is mostly for 
legacy guests that doesn't have pv spinlocks.

Paolo

> I maybe wrong. Anyway, I plan to add code to
> schedule out the CPUs waiting in the queue except the first 2 in the
> next version of the patch.
>
> The PV code in the v5 patch did seem to improve benchmark performance
> with moderate to heavy spinlock contention. However, I didn't see much
> CPU kicking going on. My theory is that the additional PV code
> complicates the pause loop timing so that the hardware PLE didn't kick
> in, whereas the original pause loop is pretty simple causing PLE to
> happen fairly frequently.
