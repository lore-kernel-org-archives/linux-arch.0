Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdBHUUt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Feb 2017 15:20:49 -0500
Subject: Re: [PATCH 1/2] x86/paravirt: Don't make vcpu_is_preempted() a
 callee-save function
References: <1486576825-17058-1-git-send-email-longman@redhat.com>
 <20170208190508.GA6515@twins.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <2bad716f-8e78-d9c0-56c9-61f5d52ab97a@redhat.com>
Date: Wed, 8 Feb 2017 15:17:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170208190508.GA6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170208201745.zLmGPxWNg4d87aGqwopR0bMzI5uXgwEHXI7g8vu6M5I@z>

On 02/08/2017 02:05 PM, Peter Zijlstra wrote:
> On Wed, Feb 08, 2017 at 01:00:24PM -0500, Waiman Long wrote:
>> It was found when running fio sequential write test with a XFS ramdisk
>> on a 2-socket x86-64 system, the %CPU times as reported by perf were
>> as follows:
>>
>>  71.27%  0.28%  fio  [k] down_write
>>  70.99%  0.01%  fio  [k] call_rwsem_down_write_failed
>>  69.43%  1.18%  fio  [k] rwsem_down_write_failed
>>  65.51% 54.57%  fio  [k] osq_lock
>>   9.72%  7.99%  fio  [k] __raw_callee_save___kvm_vcpu_is_preempted
>>   4.16%  4.16%  fio  [k] __kvm_vcpu_is_preempted
>>
>> So making vcpu_is_preempted() a callee-save function has a pretty high
>> cost associated with it. As vcpu_is_preempted() is called within the
>> spinlock, mutex and rwsem slowpaths, there isn't much to gain by making
>> it callee-save. So it is now changed to a normal function call instead.
>>
> Numbers for bare metal too please.

I will run the test on bare metal, but I doubt there will be noticeable
difference.

Cheers,
Longman

