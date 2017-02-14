Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdBNOqZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Feb 2017 09:46:25 -0500
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
 callee-save function
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
 <20170210161928.GI6515@twins.programming.kicks-ass.net>
 <1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
 <14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
 <20170213104716.GM6515@twins.programming.kicks-ass.net>
 <20170213105343.GJ6536@twins.programming.kicks-ass.net>
 <3dc50409-60dd-ad47-f971-448191e66038@redhat.com>
 <6f69b112-7ae4-bf8f-b767-29a68fd48632@redhat.com>
 <20170213215220.GN25813@worktop.programming.kicks-ass.net>
 <933ba8c6-4ebe-63e2-3c3a-2e5afef9269a@redhat.com>
 <20170214093946.GM6500@twins.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <fc65322b-902e-6589-f64c-62be5abdb093@redhat.com>
Date: Tue, 14 Feb 2017 09:46:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170214093946.GM6500@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170214144617.c03rjtj4eQ94LzfEmzt5C8Q_9nh8PfyIVh5Ntdoa8eg@z>

On 02/14/2017 04:39 AM, Peter Zijlstra wrote:
> On Mon, Feb 13, 2017 at 05:34:01PM -0500, Waiman Long wrote:
>> It is the address of &steal_time that will exceed the 32-bit limit.
> That seems extremely unlikely. That would mean we have more than 4G
> worth of per-cpu variables declared in the kernel.

I have some doubt about if the compiler is able to properly use
RIP-relative addressing for this. Anyway, it seems like constraints
aren't allowed for asm() when not in the function context, at least for
the the compiler that I am using (4.8.5). So it is a moot point.

Cheers,
Longman


