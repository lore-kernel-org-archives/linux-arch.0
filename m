From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Mon, 13 Feb 2017 22:57:38 +0100
Message-ID: <20170213215738.GO25813@worktop.programming.kicks-ass.net>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
	<20170210161928.GI6515@twins.programming.kicks-ass.net>
	<1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
	<14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
	<20170213104716.GM6515@twins.programming.kicks-ass.net>
	<20170213105343.GJ6536@twins.programming.kicks-ass.net>
	<F29A7066-16B9-4542-A686-292EC9CFF96E@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F29A7066-16B9-4542-A686-292EC9CFF96E@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: hpa@zytor.com
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Waiman Long <longman@redhat.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 13, 2017 at 12:06:44PM -0800, hpa@zytor.com wrote:

> >Maybe:
> >
> >movsql %edi, %rax;
> >movq __per_cpu_offset(,%rax,8), %rax;
> >cmpb $0, %[offset](%rax);
> >setne %al;
> >
> >?
> 
> We could kill the zero or sign extend by changing the calling
> interface to pass an unsigned long instead of an int.  It is much more
> likely that a zero extend is free for the caller than a sign extend.

Right, Boris and me talked about that on IRC. I was wondering if the
argument was u32 if we could assume the top 32 bits are 0 and then use
rdi without prior movzx.

That would allow reducing the thing one more instruction.

Also, PVOP_CALL_ARG#() have an (unsigned long) cast in them that doesn't
make sense. That cast ends up resulting in the calling code doing
explicit sign or zero extends into the full 64bit register for no good
reason.

If one removes that cast things still compile, but I worry something
somehow relies on this weird behaviour and will come apart.
