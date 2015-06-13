From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 1/2] locking/qrwlock: Fix bug in interrupt handling
 code
Date: Fri, 12 Jun 2015 23:16:15 -0400
Message-ID: <557BA07F.8060501@hp.com>
References: <1433863153-30722-1-git-send-email-Waiman.Long@hp.com> <1433863153-30722-2-git-send-email-Waiman.Long@hp.com> <20150611142139.GB29425@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:3397 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbbFMDQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jun 2015 23:16:20 -0400
In-Reply-To: <20150611142139.GB29425@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 06/11/2015 10:21 AM, Will Deacon wrote:
> Hi Waiman,
>
> On Tue, Jun 09, 2015 at 04:19:12PM +0100, Waiman Long wrote:
>> The qrwlock is fair in the process context, but becoming unfair when
>> in the interrupt context to support use cases like the tasklist_lock.
>> However, the unfair code in the interrupt context has problem that
>> may cause deadlock.
>>
>> The fast path increments the reader count. In the interrupt context,
>> the reader in the slowpath will wait until the writer release the
>> lock. However, if other readers have the lock and the writer is just
>> in the waiting mode. It will never get the write lock because the
>> that interrupt context reader has increment the count. This will
>> cause deadlock.
> I'm probably just being thick here, but I'm struggling to understand the
> deadlock case.
>
> If a reader enters the slowpath in interrupt context, we spin while
> (cnts&  _QW_WMASK) == _QW_LOCKED. Consequently, if there is a writer in
> the waiting state, that won't hold up the reader and so forward progress
> is ensured. When the reader unlocks, the reader count is decremented and
> the writer can take the lock.
>
> The only problematic case I can think of is if you had a steady stream of
> readers in interrupt context, but that doesn't seem likely (and I don't
> think this patch deals with that anyway).
>
> What am I missing?
>
> Will

You are right. It was my mistake. I misread my own code. I should have a 
comment to clarify that. I will send out a revised one next week.

Cheers,
Longman
