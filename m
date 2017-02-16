Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933581AbdBPVDC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Feb 2017 16:03:02 -0500
Subject: Re: [PATCH v4 1/2] x86/paravirt: Change vcp_is_preempted() arg type
 to long
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
 <1487194670-6319-2-git-send-email-longman@redhat.com>
 <20170216160930.GC6515@twins.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <ac84bb22-6211-50e2-5b53-2f95c9142d76@redhat.com>
Date: Thu, 16 Feb 2017 16:02:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170216160930.GC6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170216210257.Z2qLgIh6rB21HiB3DbUhjlbXl0v30k_6oWAL0fSSgiU@z>

On 02/16/2017 11:09 AM, Peter Zijlstra wrote:
> On Wed, Feb 15, 2017 at 04:37:49PM -0500, Waiman Long wrote:
>> The cpu argument in the function prototype of vcpu_is_preempted()
>> is changed from int to long. That makes it easier to provide a better
>> optimized assembly version of that function.
>>
>> For Xen, vcpu_is_preempted(long) calls xen_vcpu_stolen(int), the
>> downcast from long to int is not a problem as vCPU number won't exceed
>> 32 bits.
>>
> Note that because of the cast in PVOP_CALL_ARG1() this patch is
> pointless.
>
> Then again, it doesn't seem to affect code generation, so why not. Takes
> away the reliance on that weird cast.

I add this patch because I am a bit uneasy about clearing the upper 32
bits of rdi and assuming that the compiler won't have a previous use of
those bits. It gives me peace of mind.

Cheers,
Longman
