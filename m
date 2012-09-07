From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v3 17/31] arm64: System calls handling
Date: Fri, 7 Sep 2012 20:54:14 +0100
Message-ID: <20120907195414.GG13973@ZenIV.linux.org.uk>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-18-git-send-email-catalin.marinas@arm.com>
 <201209071943.37184.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37511 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757082Ab2IGTyS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:54:18 -0400
Content-Disposition: inline
In-Reply-To: <201209071943.37184.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Sep 07, 2012 at 07:43:36PM +0000, Arnd Bergmann wrote:
> > +       asm(    "add    x0, %0, %1\n\t"
> > +               "mov    x1, %2\n\t"
> > +               "mov    x2, %3\n\t"
> > +               "bl     memmove\n\t"    /* copy regs to top of stack */
> > +               "mov    x27, #0\n\t"    /* not a syscall */
> > +               "mov    x28, %0\n\t"    /* thread structure */
> > +               "mov    sp, x0\n\t"     /* reposition stack pointer */
> > +               "b      ret_to_user"
> > +               :
> > +               : "r" (current_thread_info()),
> > +                 "Ir" (THREAD_START_SP - sizeof(regs)),
> > +                 "r" (&regs),
> > +                 "Ir" (sizeof(regs))
> > +               : "x0", "x1", "x2", "x27", "x28", "x30", "memory");

This should just become ret_from_kernel_execve(); FWIW, arm variant is
ENTRY(ret_from_kernel_execve)
        mov     why, #0                 @ not a syscall
        str     why, [r1, #S_R0]        @ ... and we want 0 in ->ARM_r0 as well
        mov     r2, #S_FRAME_SIZE
        bl      memmove                 @ copy regs to normal location; return
                                        @ value is in r0 and it's the same as
                                        @ the first argument, so r0 is unchanged.
        get_thread_info tsk             @ thread structure
        mov     sp, r0                  @ stack pointer just under pt_regs
        b       ret_slow_syscall

and AFAICS you want pretty much the same, modulo different registers - 'why'
(aka r8) seems to correspond to your x27, 'tsk' (aka r9) - to x28 and the rest
matches one-to-one: x1.. for arguments in place of r1.. and x0 for return value
(instead of r0)...
