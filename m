Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:52242 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfEWO7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2019 10:59:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-4-ebiederm@xmission.com>
        <20190523101702.GG26646@fuggles.cambridge.arm.com>
Date: Thu, 23 May 2019 09:59:20 -0500
In-Reply-To: <20190523101702.GG26646@fuggles.cambridge.arm.com> (Will Deacon's
        message of "Thu, 23 May 2019 11:17:02 +0100")
Message-ID: <87d0k9gqt3.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20190523145920.q3rGPJEu6xMpPJNw46o2rezU9lEjs8jHJ-E6LiyRePc@z>

Will Deacon <will.deacon@arm.com> writes:

> On Wed, May 22, 2019 at 07:38:53PM -0500, Eric W. Biederman wrote:
>> It really only matters to debuggers but the SIGKILL does not have any
>> si_codes that use the fault member of the siginfo union.  Correct this
>> the simple way and call force_sig instead of force_sig_fault when the
>> signal is SIGKILL.
>> 
>> Cc: stable@vger.kernel.org
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Fixes: af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/arm64/kernel/traps.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index ade32046f3fe..0feb17bdcaa0 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -282,6 +282,11 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>>  		current->thread.fault_address = 0;
>>  		current->thread.fault_code = err;
>>  
>> +		if (signo == SIGKILL) {
>> +			arm64_show_signal(signo, str);
>> +			force_sig(signo, current);
>> +			return;
>> +		}
>
> I know it's a bit of a misnomer, but I'd rather do this check inside
> arm64_force_sig_fault, since I think we have other callers (e.g.
> do_bad_area()) which also blindly pass in SIGKILL here.

Sigh.  You are right.

I thought I had checked for that when I made my change there.  But
do_bad_area will definitely do that, and that was one of the cases that
jumped out at me as needing to be fixed, when I skimmed the arm code.

I will respin this patch to move that lower.

> We could rename the thing if necessary.

I would not mind but as long as we aren't misusing the generic bits
I won't have alarm bells going of in my head when I look at their
users.

Eric
