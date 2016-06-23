From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86,
 core)
Date: Thu, 23 Jun 2016 16:31:26 +0200
Message-ID: <20160623143126.GA16664@redhat.com>
References: <cover.1466466093.git.luto@kernel.org>
 <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
 <CALCETrUuG0-tGNQ5iAEO2_gaK1eUq7AoALoBeQKcOP8cvxr=eA@mail.gmail.com>
 <CA+55aFx480bxx7VAmFqdsVGHjoSav4eCvVpcx5ZSpBQuq+=1Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbcFWObb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Jun 2016 10:31:31 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFx480bxx7VAmFqdsVGHjoSav4eCvVpcx5ZSpBQuq+=1Mw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On 06/22, Linus Torvalds wrote:
>
> Oleg, what do you think? Would it be reasonable to free the stack and
> thread_info synchronously at exit time, clear the pointer (to catch
> any odd use), and only RCU-delay the task_struct itself?

I didn't see the patches yet, quite possibly I misunderstood... But no,
I don't this we can do this (if we are not going to move ti->flags to
task_struct at least).

> (Obviously, we can't release it in do_exit() itself like we do some of
> the other state - it would need to be released after we've scheduled
> away to another process' stack, but we already have that TASK_DEAD
> handling in finish_task_switch for this exact reason).

Yes, but the problem is that a zombie thread can do its last schedule
before it is reaped.

Just for example, syscall_regfunc() does

		read_lock(&tasklist_lock);
		for_each_process_thread(p, t) {
			set_tsk_thread_flag(t, TIF_SYSCALL_TRACEPOINT);
		}
		read_unlock(&tasklist_lock);

and this can easily hit a TASK_DEAD thread with ->stack == NULL.

And we can't free/nullify it when the parent/debuger reaps a zombie,
say, mark_oom_victim() expects that get_task_struct() protects
thread_info as well.

Oleg.
