From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 9/9] qspinlock,x86,kvm: Implement KVM support for
	paravirt qspinlock
Date: Thu, 19 Mar 2015 11:01:21 +0100
Message-ID: <20150319100121.GL21418@twins.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
	<20150316133112.333845162@infradead.org> <550A3863.2060808@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <550A3863.2060808@hp.com>
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
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 18, 2015 at 10:45:55PM -0400, Waiman Long wrote:
> On 03/16/2015 09:16 AM, Peter Zijlstra wrote:
> I do have some concern about this call site patching mechanism as the
> modification is not atomic. The spin_unlock() calls are in many places in
> the kernel. There is a possibility that a thread is calling a certain
> spin_unlock call site while it is being patched by another one with the
> alternative() function call.
> 
> So far, I don't see any problem with bare metal where paravirt_patch_insns()
> is used to patch it to the move instruction. However, in a virtual guest
> enivornment where paravirt_patch_call() was used, there were situations
> where the system panic because of page fault on some invalid memory in the
> kthread. If you look at the paravirt_patch_call(), you will see:
> 
>     :
> b->opcode = 0xe8; /* call */
> b->delta = delta;
> 
> If another CPU reads the instruction at the call site at the right moment,
> it will get the modified call instruction, but not the new delta value. It
> will then jump to a random location. I believe that was causing the system
> panic that I saw.
> 
> So I think it is kind of risky to use it here unless we can guarantee that
> call site patching is atomic wrt other CPUs.

Just look at where the patching is done:

init/main.c:start_kernel()
  check_bugs()
    alternative_instructions()
      apply_paravirt()

We're UP and not holding any locks, disable IRQs (see text_poke_early())
and have NMIs 'disabled'.
