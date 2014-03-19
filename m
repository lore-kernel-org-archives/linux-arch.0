From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
	PV guest
Date: Tue, 18 Mar 2014 23:08:26 -0400
Message-ID: <53290A2A.4090801@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>
	<20140313151515.GC25546@laptop.programming.kicks-ass.net>
	<53220F7F.2040701@hp.com>
	<20140314083001.GN27965@twins.programming.kicks-ass.net>
	<53273482.3030102@hp.com>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu
List-Id: linux-arch.vger.kernel.org

On 03/17/2014 02:54 PM, Peter Zijlstra wrote:
> On Mon, Mar 17, 2014 at 01:44:34PM -0400, Waiman Long wrote:
>> The PV ticketlock code was designed to handle lock holder preemption by
>> redirecting CPU resources in a preempted guest to another guest that can
>> better use it and then return the preempted CPU back sooner.
> But that's the PV code, not the unfair bit. And your fuller PV thing
> doesn't need the unfair option.

What I am want to try out is to combine the PV thing with the unfair 
lock and see how it performs together. I had set up 2 virtual guests 
sharing 20 vCPUs (200% overcommit). Preliminary testing showed that 
unfair lock was a bit faster than PV, but PV seems to be a bit more 
energy efficient (less total sys+user time).  I will have more data to 
share tomorrow.

-Longman
