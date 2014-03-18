From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
	PV guest
Date: Tue, 18 Mar 2014 09:16:48 +0100
Message-ID: <532800F0.10009@redhat.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>	<20140313151515.GC25546@laptop.programming.kicks-ass.net>	<53220F7F.2040701@hp.com>	<20140314083001.GN27965@twins.programming.kicks-ass.net>	<53273482.3030102@hp.com>
	<20140317185447.GM25546@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140317185447.GM25546@laptop.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <waiman.long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

Il 17/03/2014 19:54, Peter Zijlstra ha scritto:
> On Mon, Mar 17, 2014 at 01:44:34PM -0400, Waiman Long wrote:
>> The PV ticketlock code was designed to handle lock holder preemption by
>> redirecting CPU resources in a preempted guest to another guest that can
>> better use it and then return the preempted CPU back sooner.
>
> But that's the PV code, not the unfair bit. And your fuller PV thing
> doesn't need the unfair option.
>

I agree.  You need three cases:

* non-virt, non-PV: regular qspinlock

* virt (X86_FEATURE_HYPERVISOR), non-PV: test-and-set

* virt, PV: disables test-and-set, adds PV waiting to qspinlock

Paolo
