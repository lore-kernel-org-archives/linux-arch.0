Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751670AbdBHTJp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Feb 2017 14:09:45 -0500
Subject: Re: [PATCH 2/2] locking/mutex,rwsem: Reduce vcpu_is_preempted()
 calling frequency
References: <1486576825-17058-1-git-send-email-longman@redhat.com>
 <1486576825-17058-2-git-send-email-longman@redhat.com>
 <20170208190533.GB6515@twins.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <f82bd691-073c-ced1-a1f3-f3cc5b2d9c96@redhat.com>
Date: Wed, 8 Feb 2017 14:09:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170208190533.GB6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170208190926.SwAEv2t5Q8TRCGmZA7csXKuvpdISS2PBmV2ErKkdfyU@z>

On 02/08/2017 02:05 PM, Peter Zijlstra wrote:
> On Wed, Feb 08, 2017 at 01:00:25PM -0500, Waiman Long wrote:
>> As the vcpu_is_preempted() call is pretty costly compared with other
>> checks within mutex_spin_on_owner() and rwsem_spin_on_owner(), they
>> are done at a reduce frequency of once every 256 iterations.
> That's just disgusting.

I do have some doubt myself on the effectiveness of this patch. Anyway,
it is the first patch that I think is more beneficial.

Cheers,
Longman

