Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47964 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbCSKBm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 06:01:42 -0400
Date: Thu, 19 Mar 2015 11:01:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 9/9] qspinlock,x86,kvm: Implement KVM support for
 paravirt qspinlock
Message-ID: <20150319100121.GL21418@twins.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
 <20150316133112.333845162@infradead.org>
 <550A3863.2060808@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550A3863.2060808@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150319100121.J1mO6UqwP2rep6Q_L-NIf_x-cfljyS9eIsQaoK_ZiJM@z>

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
