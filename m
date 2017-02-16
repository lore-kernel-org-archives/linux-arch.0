Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbdBPQJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2017 11:09:48 -0500
Date: Thu, 16 Feb 2017 17:09:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] x86/paravirt: Change vcp_is_preempted() arg type
 to long
Message-ID: <20170216160930.GC6515@twins.programming.kicks-ass.net>
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
 <1487194670-6319-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487194670-6319-2-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170216160930.RavG50JAz7PGz7Sziu2WqQCATZl519IZxMVB5qD9rH4@z>

On Wed, Feb 15, 2017 at 04:37:49PM -0500, Waiman Long wrote:
> The cpu argument in the function prototype of vcpu_is_preempted()
> is changed from int to long. That makes it easier to provide a better
> optimized assembly version of that function.
> 
> For Xen, vcpu_is_preempted(long) calls xen_vcpu_stolen(int), the
> downcast from long to int is not a problem as vCPU number won't exceed
> 32 bits.
> 

Note that because of the cast in PVOP_CALL_ARG1() this patch is
pointless.

Then again, it doesn't seem to affect code generation, so why not. Takes
away the reliance on that weird cast.
