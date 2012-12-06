From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 23/44] metag: Traps
Date: Thu, 6 Dec 2012 11:43:56 +0000
Message-ID: <50C084FC.8040104@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <1354723742-6195-24-git-send-email-james.hogan@imgtec.com> <20121205174035.GX4939@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56888 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423208Ab2LFLn7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Dec 2012 06:43:59 -0500
In-Reply-To: <20121205174035.GX4939@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Hi Al,

On 05/12/12 17:40, Al Viro wrote:
> On Wed, Dec 05, 2012 at 04:08:41PM +0000, James Hogan wrote:
>> +TBIRES tail_end(TBIRES State, unsigned long orig_syscall)
>> +{
>> +	struct pt_regs *regs = (struct pt_regs *)State.Sig.pCtx;
>> +	unsigned long flags;
>> +
>> +	if (user_mode(regs)) {
>> +		local_irq_enable();
>> +		/* This is actually a crucial little line - if the process
>> +		 * needs swapping out, then this is where it happens!
>> +		 */
>> +		if (need_resched())
>> +			schedule();
>> +
>> +		flags = current_thread_info()->flags;
>> +		if (flags & (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME)) {
>> +			/* Note the passing in of the original syscall number.
>> +			 * This is used for implementing signal restart.
>> +			 */
>> +			do_notify_resume(regs, orig_syscall != 0,
>> +					 orig_syscall, flags);
> 
> Owww....  So
> 	a) you can't get there with !user_mode(regs)
> 	b) you handle only one signal (what happens if you fail sigframe
> allocation, BTW?  Sure, you get SIGSEGV delivered.  And don't handle it.)

I see, this indeed looks wrong.

If I understand correctly the second go around the loop when it asked
for the next signal should either stop process (SIGSEGV), or try to
invoke signal handler for SIGSEGV, and if allocation failed again it
would see it's already in a SIGSEGV (in force_sigsegv), change handler
to default, so that on the third go around the loop the process would
get stopped.

> 	c) you read ->flags with no protection whatsoever.  It should be
> done *before* you enable interrupts, and rechecked after you've done
> do_notify_resume() and redisabled them.  The same for schedule().  It really
> should be a loop; take a look at how it's done on arm and alpha - there that
> loop is in C, not in asm glue.

Thanks for pointing to ARM/alpha versions. This definitely needs some work.

> 	d) looks like your sigreturn is, indeed, broken.  It should *not* have
> syscall restart logics triggered at all.

I presume this is related to the other email about preventing syscall
restart logic for sigreturn. I can't see how any other arches prevent it
though.

Thanks a lot
James
