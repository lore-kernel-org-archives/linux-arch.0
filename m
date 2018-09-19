Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:38756 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISMXN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 08:23:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-2-ebiederm@xmission.com>
        <20180919054653.GA32263@infradead.org>
Date: Wed, 19 Sep 2018 08:46:30 +0200
In-Reply-To: <20180919054653.GA32263@infradead.org> (Christoph Hellwig's
        message of "Tue, 18 Sep 2018 22:46:53 -0700")
Message-ID: <87pnxaf0hl.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in it's only caller send_sigtrap
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180919064630.3OtEeqT8TWMII3_kJKpXW0k6gJV8Kw3b7w1b3vcS47g@z>

Christoph Hellwig <hch@infradead.org> writes:

>>  
>>  	clear_siginfo(&info);
>> -	fill_sigtrap_info(tsk, regs, error_code, si_code, &info);
>> +	tsk->thread.trap_nr = X86_TRAP_DB;
>> +	tsk->thread.error_code = error_code;
>> +
>> +	info.si_signo = SIGTRAP;
>> +	info.si_code = si_code;
>> +	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
>
> clear_siginfo already zeroes the whole structure, so this could be
> written more clearly as:
>
> 	if (user_mode(regs)
> 		info.si_addr = (void __user *)regs->ip;

That change does not make sense in this particular patch as it is just
code motion.

It also does not make sense in the final version of the code at
the end of the patch series which is:

void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
					 int error_code, int si_code)
{
	tsk->thread.trap_nr = X86_TRAP_DB;
	tsk->thread.error_code = error_code;

	/* Send us the fake SIGTRAP */
	force_sig_fault(SIGTRAP, si_code,
			user_mode(regs) ? (void __user *)regs->ip : NULL, tsk);
}

In this version the test also makes sense because struct siginfo is
gone because manually filling it out results in more bugs than
necessary.  That is now left up to force_sig_fault.

I was hoping that we could show that user_mode(regs) is always true.
But according to arch/x86/kernel/traps.c:do_debug watch points that will
trigger even when the kernel accesses user space addresses.

Eric
