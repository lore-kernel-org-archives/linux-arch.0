From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH v1 16/31] ARC: Signal handling
Date: Fri, 28 Dec 2012 18:04:09 +0530
Message-ID: <50DD91C1.3000809@synopsys.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-17-git-send-email-vgupta@synopsys.com> <20121116052628.GC22671@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121116052628.GC22671@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 16 November 2012 10:56 AM, Al Viro wrote:
>> +	if (insyscall) {
>> +		/* No handler for syscall: restart it */
>> +		if (regs->r0 == -ERESTARTNOHAND ||
>> +		    regs->r0 == -ERESTARTSYS || regs->r0 == -ERESTARTNOINTR) {
>> +			regs->r0 = regs->orig_r0;
>> +			regs->ret -= 4;
>> +		} else if (regs->r0 == -ERESTART_RESTARTBLOCK) {
>> +			regs->r8 = __NR_restart_syscall;
>> +			regs->ret -= 4;
>> +		}
> 
> What's to prevent double decrement on ->ret if two signals arrive?   Note
> that e.g. x86 gets away with similar code only because it uses the same
> register for syscall number and return value; since none of -ERESTART...
> is a valid syscall number, we either won't get into an analog of that code at
> all (-ENOSYS is not restart-worthy) or will revert to a value that is
> a valid syscall number, so all subsequent do_signal() calls will not hit
> that code.  This is subtle and unfortunately not spelled out in the
> architectures where it is enough.

Ok that is fixed now, by saving additional state in pt_regs->orig_r8 (which
required redoing how we kept information in it).

-       long orig_r8;   /*to distinguish bet excp, sys call, int1 or int2
-                         * syscalls   -> 1 to NR_SYSCALLS
-                         * Exceptions -> NR_SYSCALLS + 1
-                         * Break-point-> NR_SYSCALLS + 2
-                         */
+       unsigned long event_type:16, orig_r8:16;

Alternately, I could have set orig_r8 to a special value, that would have been
simpler, but it would have meant potential breakage if one of the intermediate
signals was tracing related - leading to a ptrace(peekxxx) which relies on orig_r8
to have correct state. Also there's tracehook stuff which could enquire for orig
syscall number in orig_r8.


> You need to make sure that after the first restart in_syscall() will be false.
> Same ought to be done in sigreturn(), BTW...
> 

Sure, this becomes very simple given the infrastructure above - patches follow for
you to take a quick peek.

Also on the topic, it seems the altstack handling is done unconditionally by most
of arches - while ARC Port does it based on a magic value. The reason being to
avoid needless calling (only to return) in sigreturn path. What's the
recommendation there.

Thx,
Vineet
