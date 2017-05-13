From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 19:04:13 +0100
Message-ID: <20170513180413.GZ390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40994 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbdEMSEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 14:04:15 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 10:18:22AM -0700, Linus Torvalds wrote:

> > x86 actually tends to use get_user_ex/put_user_ex instead.
> 
> Yes. Because anybody who *really* cared about performance will have
> converted already. The real cost has been stac/clac for a few years
> now.

On x86.  Which has (not counting arch/x86/um, which definitely needs
a careful look - there __..._user() is the same as ..._user() and costly
as hell) all of 12 callers of __get_user() and 31 callers of __put_user().
More than a half of the latter - in cp_stat64() and I would at least try
and see if "convert on stack, then copy_to_user" is better for that one.
Other than that, all we have is:

arch/x86/entry/common.c:372:            __get_user(*(u32 *)&regs->bp,
arch/x86/ia32/ia32_signal.c:124:        if (__get_user(set.sig[0], &frame->sc.oldmask)
arch/x86/ia32/ia32_signal.c:275:        if (__put_user(sig, &frame->sig))
arch/x86/include/asm/xen/page.h:86:     return __put_user(val, (unsigned long __user *)addr);
arch/x86/include/asm/xen/page.h:91:     return __get_user(*val, (unsigned long __user *)addr);
arch/x86/kernel/fpu/signal.c:100:       err |= __get_user(xfeatures, (__u32 *)&x->header.xfeatures);
arch/x86/kernel/fpu/signal.c:115:       err |= __put_user(xfeatures, (__u32 *)&x->header.xfeatures);
arch/x86/kernel/fpu/signal.c:46:        if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size))
arch/x86/kernel/fpu/signal.c:66:                    __put_user(xsave->i387.swd, &fp->status) ||
arch/x86/kernel/fpu/signal.c:67:                    __put_user(X86_FXSR_MAGIC, &fp->magic))
arch/x86/kernel/fpu/signal.c:72:                if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
arch/x86/kernel/fpu/signal.c:72:                if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
arch/x86/kernel/fpu/signal.c:93:        err |= __put_user(FP_XSTATE_MAGIC2,
arch/x86/kernel/ptrace.c:1043:                  if (__put_user(word, u++))
arch/x86/kernel/ptrace.c:1070:                  ret = __get_user(word, u++);
arch/x86/kernel/ptrace.c:472:                   if (__put_user(getreg(target, pos), u++))
arch/x86/kernel/ptrace.c:499:                   ret = __get_user(word, u++);
arch/x86/kernel/signal.c:326:   if (__put_user(sig, &frame->sig))
arch/x86/kernel/signal.c:347:   err |= __put_user(restorer, &frame->pretcode);
arch/x86/kernel/signal.c:356:   err |= __put_user(*((u64 *)&retcode), (u64 *)frame->retcode);
arch/x86/kernel/signal.c:613:   if (__get_user(set.sig[0], &frame->sc.oldmask) || (_NSIG_WORDS > 1
arch/x86/kernel/signal.c:647:   if (__get_user(uc_flags, &frame->uc.uc_flags))
arch/x86/kernel/signal.c:870:   if (__get_user(uc_flags, &frame->uc.uc_flags))
arch/x86/lib/csum-wrappers_64.c:103:                    *errp = __put_user(val16, (__u16 __user *)dst);
arch/x86/lib/csum-wrappers_64.c:45:                     if (__get_user(val16, (const __u16 __user *)src))

A bunch of strays in signal.c (extending ..._ex use might be a good idea)
xen_safe_{write,read}_ulong() (might very well break from adding access_ok() -
or be security holes; I'm not familiar enough with that code to tell) and
csum_partial_copy_{to,from}_user() - those would need to extend stac/clac
pairs already there and switch to unsafe_...

Plus several loops in ptrace - might or might not be sensitive, no idea.

Plus do_fast_syscall_32().  Might be sensitive, Andy would be the guy to
talk to, AFAICS.

> And some of the existing cases are just disgusting. There's no excuse
> for compat code or for ioctl to use the "__" versions. That seems to
> be the bulk of those uses too.

Sure.

My point is, this stuff needs looking at.  Even this quick look in arch/x86
has shown several fairly different classes of that stuff, probably needing
different approaches.  And that - on an architecture that had tons of TLC
around signal delivery; I'm not saying that result is optimal (asm-goto sounds
potentially useful there), but it had a lot of attention given to it...
