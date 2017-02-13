Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdBMV7l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2017 16:59:41 -0500
Date: Mon, 13 Feb 2017 22:57:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
 callee-save function
Message-ID: <20170213215738.GO25813@worktop.programming.kicks-ass.net>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
 <20170210161928.GI6515@twins.programming.kicks-ass.net>
 <1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
 <14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
 <20170213104716.GM6515@twins.programming.kicks-ass.net>
 <20170213105343.GJ6536@twins.programming.kicks-ass.net>
 <F29A7066-16B9-4542-A686-292EC9CFF96E@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F29A7066-16B9-4542-A686-292EC9CFF96E@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com
Cc: Waiman Long <longman@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170213215738.2csgwR3HbEOp1stM-nd4RDO7S1qySriEpXAucteso-U@z>

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
