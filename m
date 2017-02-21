Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35664 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbdBULtK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2017 06:49:10 -0500
Subject: Re: [PATCH v5 0/2] x86/kvm: Reduce vcpu_is_preempted() overhead
References: <1487615764-1343-1-git-send-email-longman@redhat.com>
 <20170220195426.GF6515@twins.programming.kicks-ass.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62938e9e-6d25-80e3-2fb2-2812ad948605@redhat.com>
Date: Tue, 21 Feb 2017 12:49:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170220195426.GF6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20170221114907.kz8DJ_UXcOMWjLwNbR8MZ_5juBBhffSILhJ-Po61A0E@z>



On 20/02/2017 20:54, Peter Zijlstra wrote:
> On Mon, Feb 20, 2017 at 01:36:02PM -0500, Waiman Long wrote:
>> Waiman Long (2):
>>   x86/paravirt: Change vcp_is_preempted() arg type to long
>>   x86/kvm: Provide optimized version of vcpu_is_preempted() for x86-64
>>
>>  arch/x86/include/asm/paravirt.h      |  2 +-
>>  arch/x86/include/asm/qspinlock.h     |  2 +-
>>  arch/x86/kernel/asm-offsets_64.c     |  9 +++++++++
>>  arch/x86/kernel/kvm.c                | 26 +++++++++++++++++++++++++-
>>  arch/x86/kernel/paravirt-spinlocks.c |  2 +-
>>  5 files changed, 37 insertions(+), 4 deletions(-)
> 
> I'm assuming this will go through the KVM tree, if people want me to
> take it through the tip tree, please let me know.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infraded.org>

Applied, thanks.

Paolo
