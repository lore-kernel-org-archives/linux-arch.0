From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 00/44] Meta Linux Kernel Port
Date: Tue, 18 Dec 2012 16:09:02 +0000
Message-ID: <50D0951E.7060503@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <20121205171131.GV4939@ZenIV.linux.org.uk> <20121205183923.GY4939@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55637 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab2LRQJE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 Dec 2012 11:09:04 -0500
In-Reply-To: <20121205183923.GY4939@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 05/12/12 18:39, Al Viro wrote:
> On Wed, Dec 05, 2012 at 05:11:32PM +0000, Al Viro wrote:
>> On Wed, Dec 05, 2012 at 04:08:18PM +0000, James Hogan wrote:
>>
>>> other work not included:
>>> * switch to generic kernel_{thread,execve} (will be posted separately to
>>>   aid review)
>>
>>> other changes:
>> ...
>>> * switch to generic sys_execve
>>
>> ... which should've broken your kernel_execve().
> 
> BTW, one general note: lose the magical 7th argument.  In the few syscalls
> that do need pt_regs, you can bloody well use current_pt_regs() instead;
> it's what, (register & constant) + constant?  Passing it as explicit
> argument is saving at most two arithmetical insns on those syscalls.
> Moreover, for fork/clone/vfork we really don't need it until copy_thread();
> one of the changes in -next kills passing pt_regs * to do_fork() and through
> all that call chain (furthermore, if you make that
> 	childregs->ctx.AX[0].U0 = ALIGN(usp, 8);
> in copy_thread() conditional on usp != 0, you can go with generic
> variants from kernel/fork.c; again, see linux-next for examples of that).
> What's left?  sigreturn and sigaltstack?
> 
> Seriously, drop that struct pt_regs *; it makes things uglier, (slightly)
> hurts the syscall overhead and doesn't help the few syscalls that even
> look at that argument.
> 

Done (with generic clone), thanks for pointing out the linux-next
changes. I'll base the next patchset on -next.

Thanks for all the review comments so far, they're much appreciated.

Cheers
James
