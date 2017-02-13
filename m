From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Mon, 13 Feb 2017 11:53:43 +0100
Message-ID: <20170213105343.GJ6536@twins.programming.kicks-ass.net>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
	<20170210161928.GI6515@twins.programming.kicks-ass.net>
	<1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
	<14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
	<20170213104716.GM6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170213104716.GM6515@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 13, 2017 at 11:47:16AM +0100, Peter Zijlstra wrote:
> That way we'd end up with something like:
> 
> asm("
> push %rdi;
> movslq %edi, %rdi;
> movq __per_cpu_offset(,%rdi,8), %rax;
> cmpb $0, %[offset](%rax);
> setne %al;
> pop %rdi;
> " : : [offset] "i" (((unsigned long)&steal_time) + offsetof(struct steal_time, preempted)));
> 
> And if we could get rid of the sign extend on edi we could avoid all the
> push-pop nonsense, but I'm not sure I see how to do that (then again,
> this asm foo isn't my strongest point).

Maybe:

movsql %edi, %rax;
movq __per_cpu_offset(,%rax,8), %rax;
cmpb $0, %[offset](%rax);
setne %al;

?
