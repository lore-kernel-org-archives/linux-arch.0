From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Mon, 13 Feb 2017 23:31:30 +0100
Message-ID: <20170213223130.GL6500@twins.programming.kicks-ass.net>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
	<20170210161928.GI6515@twins.programming.kicks-ass.net>
	<1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
	<14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
	<20170213104716.GM6515@twins.programming.kicks-ass.net>
	<20170213105343.GJ6536@twins.programming.kicks-ass.net>
	<F29A7066-16B9-4542-A686-292EC9CFF96E@zytor.com>
	<19008130-7b73-5c53-3cb5-a013e9e5552b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <19008130-7b73-5c53-3cb5-a013e9e5552b@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 13, 2017 at 05:24:36PM -0500, Waiman Long wrote:

> >> movsql %edi, %rax;
> >> movq __per_cpu_offset(,%rax,8), %rax;
> >> cmpb $0, %[offset](%rax);
> >> setne %al;

> I have thought of that too. However, the goal is to eliminate memory
> read/write from/to stack. Eliminating a register sign-extend instruction
> won't help much in term of performance.

Problem here is that all instructions have dependencies, so if you can
get rid of the sign extend mov you kill a bunch of stall cycles (I would
expect).

But yes, peanuts vs the stack load/stores.
