From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v4 25/29] um: Stop conflating task_struct::stack with thread_info
Date: Sun, 26 Jun 2016 19:40:48 -0400
Message-ID: <CAMzpN2iajQJGh1x0cE5HDnejJi2ifAqn_b4qLFvuogb-32jjmg@mail.gmail.com>
References: <cover.1466974736.git.luto@kernel.org> <2730161a8000f2b5cef009483d92fee81fe900d5.1466974736.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34824 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcFZXku (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jun 2016 19:40:50 -0400
In-Reply-To: <2730161a8000f2b5cef009483d92fee81fe900d5.1466974736.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Sun, Jun 26, 2016 at 5:55 PM, Andy Lutomirski <luto@kernel.org> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> thread_info may move in the future, so use the accessors.
>
> [changelog written by Andy]
> Message-Id: <CA+55aFxvZhBu9U1cqpVm4frv0p5mqu=0TxsSqE-=95ft8HvCVA@mail.gmail.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/um/ptrace_32.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
> index ebd4dd6ef73b..14e8f6a628c2 100644
> --- a/arch/x86/um/ptrace_32.c
> +++ b/arch/x86/um/ptrace_32.c
> @@ -191,7 +191,7 @@ int peek_user(struct task_struct *child, long addr, long data)
>
>  static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
>  {
> -       int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
> +       int err, n, cpu = task_thread_info(child)->cpu;

Shouldn't this use task_cpu() like in patch 23?

--
Brian Gerst
