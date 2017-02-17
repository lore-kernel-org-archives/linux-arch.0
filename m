Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbdBQJnz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2017 04:43:55 -0500
Date: Fri, 17 Feb 2017 10:42:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] x86/paravirt: Change vcp_is_preempted() arg type
 to long
Message-ID: <20170217094239.GA6500@twins.programming.kicks-ass.net>
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
 <1487194670-6319-2-git-send-email-longman@redhat.com>
 <20170216160930.GC6515@twins.programming.kicks-ass.net>
 <ac84bb22-6211-50e2-5b53-2f95c9142d76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac84bb22-6211-50e2-5b53-2f95c9142d76@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170217094239.BZQgzGhDOI_1RfyP4Lwd1yhbn7LM82Tdl1nAVBSPw0w@z>

On Thu, Feb 16, 2017 at 04:02:57PM -0500, Waiman Long wrote:
> On 02/16/2017 11:09 AM, Peter Zijlstra wrote:
> > On Wed, Feb 15, 2017 at 04:37:49PM -0500, Waiman Long wrote:
> >> The cpu argument in the function prototype of vcpu_is_preempted()
> >> is changed from int to long. That makes it easier to provide a better
> >> optimized assembly version of that function.
> >>
> >> For Xen, vcpu_is_preempted(long) calls xen_vcpu_stolen(int), the
> >> downcast from long to int is not a problem as vCPU number won't exceed
> >> 32 bits.
> >>
> > Note that because of the cast in PVOP_CALL_ARG1() this patch is
> > pointless.
> >
> > Then again, it doesn't seem to affect code generation, so why not. Takes
> > away the reliance on that weird cast.
> 
> I add this patch because I am a bit uneasy about clearing the upper 32
> bits of rdi and assuming that the compiler won't have a previous use of
> those bits. It gives me peace of mind.

So currently the PVOP_CALL_ARG#() macros force cast everything to
(unsigned long) anyway, but it would be good not to rely on that I
think, so yes.
