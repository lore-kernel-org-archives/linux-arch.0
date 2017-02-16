Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933481AbdBPVAS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Feb 2017 16:00:18 -0500
Subject: Re: [PATCH v4 2/2] x86/kvm: Provide optimized version of
 vcpu_is_preempted() for x86-64
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
 <1487194670-6319-3-git-send-email-longman@redhat.com>
 <20170216164815.GD6515@twins.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <9c101df4-7320-556a-ca41-e024629e9a67@redhat.com>
Date: Thu, 16 Feb 2017 16:00:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170216164815.GD6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, andrew.cooper3@citrix.com
Message-ID: <20170216210010.D-TK7tyEPVyWHemnbfCKCps5sOkKBlf1E4nzOx5JyeY@z>

On 02/16/2017 11:48 AM, Peter Zijlstra wrote:
> On Wed, Feb 15, 2017 at 04:37:50PM -0500, Waiman Long wrote:
>> +/*
>> + * Hand-optimize version for x86-64 to avoid 8 64-bit register saving and
>> + * restoring to/from the stack. It is assumed that the preempted value
>> + * is at an offset of 16 from the beginning of the kvm_steal_time structure
>> + * which is verified by the BUILD_BUG_ON() macro below.
>> + */
>> +#define PREEMPTED_OFFSET	16
> As per Andrew's suggestion, the 'right' way is something like so.

Thanks for the tip. I was not aware of the asm-offsets stuff. I will
update the patch to use it.

Cheers,
Longman
