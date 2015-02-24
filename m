Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:39893 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbbBXCcm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Feb 2015 21:32:42 -0500
Received: by wggx12 with SMTP id x12so2487416wgg.6
        for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2015 18:32:41 -0800 (PST)
Message-ID: <54EBE238.8060400@vanguardiasur.com.ar>
Date: Mon, 23 Feb 2015 23:30:16 -0300
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Subject: nios2: is the ptrace ABI correct?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>, Chung-Ling Tang <cltang@codesourcery.com>, Walter Goossens <waltergoossens@home.nl>, Ley Foon Tan <lftan@altera.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>
Cc: linux-arch@vger.kernel.org
Message-ID: <20150224023016.WADdHWFIWQ0Je2T9dLarkuDJsJSBpRXOp5cQ07uDBSw@z>

Hi everyone,

I've been trying to port strace to Nios-II, but came across some oddities
in the ptrace ABI. The pt_regs structure is exposed to userspace through
the ptrace.h UAPI header: arch/nios2/include/uapi/asm/ptrace.h

Such pt_regs has the following layout:

struct pt_regs {
        unsigned long  r8;
        unsigned long  r9;
        unsigned long  r10;
	[and so on]
}

But the regset implementation in arch/nios2/kernel/ptrace.c
pushes a different layout to userspace, as it uses the PTR_
macros, also in the UAPI header:

#define PTR_R0          0
#define PTR_R1          1
#define PTR_R2          2
#define PTR_R3          3
#define PTR_R4          4
#define PTR_R5          5
#define PTR_R6          6
#define PTR_R7          7
#define PTR_R8          8
[..]

In other words, the PTRACE_GETREGSET will pass to userspace register
r8 at offset 8*4, but the pt_regs structure says it's at offset 0.

This difference appears because ptrace returns one layout to userspace,
and pushes the registers to the stack with another layout.

I've fixed this and managed to port strace by changing the genregs_get
implementation, so it returns a layout that matches pt_regs, and therefore
matches the stack.

Having this one-to-one correspondence, has a nice benefit. The implementation
is trivial:

static int genregs_get(struct task_struct *target,
                       const struct user_regset *regset,
                       unsigned int pos, unsigned int count,
                       void *kbuf, void __user *ubuf)
{
        const struct pt_regs *regs = task_pt_regs(target);
        const struct switch_stack *sw = (struct switch_stack *)regs - 1;
        int ret;

        ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
                                  regs, 0, PT_REGS_SIZE);
        if (!ret)
                ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
                                          sw, 0, SWITCH_STACK_SIZE);
        return ret;
}

However, there's a problem. The ABI is already different, and current gdb
seems to rely in the current layout. However, it does it by *not* using the
pt_regs structure.

Give the ABI is already used, I'm reluctant to change it as I don't want to
break our beloved users.

So, tried a different approach and removed pt_regs from the UAPI ptrace.h,
replacing it with a new user_regs that describes how registers are passed
to user. This however is also problematic, as pt_regs is already used
by glibc (not really sure what for).

In conclusion, I'm lost and have no clue how a proper fix
would look like. (Or perhaps, I'm really lost and there's no fix needed.)

Any ideas?

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
