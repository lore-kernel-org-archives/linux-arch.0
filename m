Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:54470 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbCSVIu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 17:08:50 -0400
Message-ID: <550B3ACF.4050908@hp.com>
Date: Thu, 19 Mar 2015 17:08:31 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 9/9] qspinlock,x86,kvm: Implement KVM support for paravirt
 qspinlock
References: <20150316131613.720617163@infradead.org> <20150316133112.333845162@infradead.org> <550A3863.2060808@hp.com> <20150319100121.GL21418@twins.programming.kicks-ass.net>
In-Reply-To: <20150319100121.GL21418@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150319210831.gKAutBS9PnTEEsx8X8j-YLAfNCSjdUW2HJfgTB_olR8@z>

On 03/19/2015 06:01 AM, Peter Zijlstra wrote:
> On Wed, Mar 18, 2015 at 10:45:55PM -0400, Waiman Long wrote:
>> On 03/16/2015 09:16 AM, Peter Zijlstra wrote:
>> I do have some concern about this call site patching mechanism as the
>> modification is not atomic. The spin_unlock() calls are in many places in
>> the kernel. There is a possibility that a thread is calling a certain
>> spin_unlock call site while it is being patched by another one with the
>> alternative() function call.
>>
>> So far, I don't see any problem with bare metal where paravirt_patch_insns()
>> is used to patch it to the move instruction. However, in a virtual guest
>> enivornment where paravirt_patch_call() was used, there were situations
>> where the system panic because of page fault on some invalid memory in the
>> kthread. If you look at the paravirt_patch_call(), you will see:
>>
>>      :
>> b->opcode = 0xe8; /* call */
>> b->delta = delta;
>>
>> If another CPU reads the instruction at the call site at the right moment,
>> it will get the modified call instruction, but not the new delta value. It
>> will then jump to a random location. I believe that was causing the system
>> panic that I saw.
>>
>> So I think it is kind of risky to use it here unless we can guarantee that
>> call site patching is atomic wrt other CPUs.
> Just look at where the patching is done:
>
> init/main.c:start_kernel()
>    check_bugs()
>      alternative_instructions()
>        apply_paravirt()
>
> We're UP and not holding any locks, disable IRQs (see text_poke_early())
> and have NMIs 'disabled'.

You are probably right. The initial apply_paravirt() was done before the 
SMP boot. Subsequent ones were at kernel module load time. I put a 
counter in the __native_queue_spin_unlock() and it registered 26949 
unlock calls in a 16-cpu guest before it got patched out.

The panic that I observed before might be due to some coding error of my 
own.

-Longman
