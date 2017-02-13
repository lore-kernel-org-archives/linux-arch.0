Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:37560 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753180AbdBMUNH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Feb 2017 15:13:07 -0500
Date: Mon, 13 Feb 2017 12:06:44 -0800
In-Reply-To: <20170213105343.GJ6536@twins.programming.kicks-ass.net>
References: <1486741389-8513-1-git-send-email-longman@redhat.com> <20170210161928.GI6515@twins.programming.kicks-ass.net> <1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com> <14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com> <20170213104716.GM6515@twins.programming.kicks-ass.net> <20170213105343.GJ6536@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a callee-save function
From: hpa@zytor.com
Message-ID: <F29A7066-16B9-4542-A686-292EC9CFF96E@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170213200644.Yy_60mykXM2cx3A5G6r6yyz0DltD8yYB-4Vh4kGBkE4@z>

On February 13, 2017 2:53:43 AM PST, Peter Zijlstra <peterz@infradead.org> wrote:
>On Mon, Feb 13, 2017 at 11:47:16AM +0100, Peter Zijlstra wrote:
>> That way we'd end up with something like:
>> 
>> asm("
>> push %rdi;
>> movslq %edi, %rdi;
>> movq __per_cpu_offset(,%rdi,8), %rax;
>> cmpb $0, %[offset](%rax);
>> setne %al;
>> pop %rdi;
>> " : : [offset] "i" (((unsigned long)&steal_time) + offsetof(struct
>steal_time, preempted)));
>> 
>> And if we could get rid of the sign extend on edi we could avoid all
>the
>> push-pop nonsense, but I'm not sure I see how to do that (then again,
>> this asm foo isn't my strongest point).
>
>Maybe:
>
>movsql %edi, %rax;
>movq __per_cpu_offset(,%rax,8), %rax;
>cmpb $0, %[offset](%rax);
>setne %al;
>
>?

We could kill the zero or sign extend by changing the calling interface to pass an unsigned long instead of an int.  It is much more likely that a zero extend is free for the caller than a sign extend.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
