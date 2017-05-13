From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 19:26:56 +0100
Message-ID: <20170513182656.GA390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41304 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbdEMS06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 14:26:58 -0400
Content-Disposition: inline
In-Reply-To: <20170513180413.GZ390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 07:04:13PM +0100, Al Viro wrote:

> My point is, this stuff needs looking at.  Even this quick look in arch/x86
> has shown several fairly different classes of that stuff, probably needing
> different approaches.  And that - on an architecture that had tons of TLC
> around signal delivery; I'm not saying that result is optimal (asm-goto sounds
> potentially useful there), but it had a lot of attention given to it...

BTW, even in arch/* they tend to nest.  E.g. arch/alpha has 133 callers
total.  Distribution by files:
     35 arch/alpha/kernel/osf_sys.c
     92 arch/alpha/kernel/signal.c
      1 arch/alpha/kernel/traps.c
      4 arch/alpha/lib/csum_partial_copy.c
      1 arch/alpha/mm/fault.c
Distribution by functions:
      1 osf_getdomainname()	[1]
      2 osf_sigstack()
      2 get_tv32()
      2 put_tv32()
      4 get_it32()
      4 put_it32()
      2 osf_select()
     18 osf_wait4()		[2]
      6 osf_sigaction()
     34 restore_sigcontext()
      1 do_sigreturn()
     42 setup_sigcontext()
      3 setup_frame()
      6 setup_rt_frame()
      1 dik_show_code()		[3]
      2 csum_partial_cfu_aligned()
      2 csum_partial_cfu_src_aligned()
      1 do_page_fault()		[4]

[1] insane, BTW - should be strnlen() + copy_to_user(); should report -EFAULT
on failure, while we are at it.
[2] with fairly disgusting use of set_fs() in the mix.
[3] would break with get_user() - it's oopser fetching code to printk.
[4] this:
        /* As of EV6, a load into $31/$f31 is a prefetch, and never faults
           (or is suppressed by the PALcode).  Support that for older CPUs
           by ignoring such an instruction.  */
        if (cause == 0) {
                unsigned int insn;
                __get_user(insn, (unsigned int __user *)regs->pc);
                if ((insn >> 21 & 0x1f) == 0x1f &&
                    /* ldq ldl ldt lds ldg ldf ldwu ldbu */
                    (1ul << (insn >> 26) & 0x30f00001400ul)) {
                        regs->pc += 4;
                        return;
                }
        }
