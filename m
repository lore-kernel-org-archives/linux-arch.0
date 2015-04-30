Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:39005 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbbD3Std (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Apr 2015 14:49:33 -0400
Message-ID: <55427936.4080900@hp.com>
Date: Thu, 30 Apr 2015 14:49:26 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v16 13/14] pvqspinlock: Improve slowpath performance by
 avoiding cmpxchg
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com> <1429901803-29771-14-git-send-email-Waiman.Long@hp.com> <20150429181112.GI23123@twins.programming.kicks-ass.net>
In-Reply-To: <20150429181112.GI23123@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150430184926.mfrAFGZGQo5C-q7XAEADCEcWED7x_qstlXuuYuG3alc@z>

On 04/29/2015 02:11 PM, Peter Zijlstra wrote:
> On Fri, Apr 24, 2015 at 02:56:42PM -0400, Waiman Long wrote:
>> In the pv_scan_next() function, the slow cmpxchg atomic operation is
>> performed even if the other CPU is not even close to being halted. This
>> extra cmpxchg can harm slowpath performance.
>>
>> This patch introduces the new mayhalt flag to indicate if the other
>> spinning CPU is close to being halted or not. The current threshold
>> for x86 is 2k cpu_relax() calls. If this flag is not set, the other
>> spinning CPU will have at least 2k more cpu_relax() calls before
>> it can enter the halt state. This should give enough time for the
>> setting of the locked flag in struct mcs_spinlock to propagate to
>> that CPU without using atomic op.
> Yuck! I'm not at all sure you can make assumptions like that. And the
> worst part is, if it goes wrong the borkage is subtle and painful.

I do think the code is OK. However, you are right that if my reasoning 
is incorrect, the resulting bug will be really subtle. So I am going to 
withdraw this particular patch as it has no functional impact to the 
overall patch series. Please let me know if you have any other comments 
on other parts of the series and I will send send out a new series 
without this particular patch.

Cheers,
Longman
