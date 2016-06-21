From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 06/13] fork: Add generic vmalloced stack support
Date: Tue, 21 Jun 2016 09:30:31 +0200
Message-ID: <CAG48ez3WGu+03HDBA5daSV+zXGoR+iFHHYxZav0o6JCM9-EPMg@mail.gmail.com>
References: <cover.1466466093.git.luto@kernel.org> <f7855f9eae0a27f5a03db1291f46fea1cc0a2a3f.1466466093.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34221 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbcFUH52 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 03:57:28 -0400
Received: by mail-io0-f176.google.com with SMTP id g13so3024468ioj.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2016 00:56:38 -0700 (PDT)
In-Reply-To: <f7855f9eae0a27f5a03db1291f46fea1cc0a2a3f.1466466093.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Tue, Jun 21, 2016 at 1:43 AM, Andy Lutomirski <luto@kernel.org> wrote:
> If CONFIG_VMAP_STACK is selected, kernel stacks are allocated with
> vmalloc_node.
[...]
>  static struct thread_info *alloc_thread_info_node(struct task_struct *tsk,
>                                                   int node)
>  {
> +#ifdef CONFIG_VMAP_STACK
> +       struct thread_info *ti = __vmalloc_node_range(
> +               THREAD_SIZE, THREAD_SIZE, VMALLOC_START, VMALLOC_END,
> +               THREADINFO_GFP | __GFP_HIGHMEM, PAGE_KERNEL,
> +               0, node, __builtin_return_address(0));
> +

After spender gave some hints on IRC about the guard pages not working
reliably, I decided to have a closer look at this. As far as I can
tell, the idea is that __vmalloc_node_range() automatically adds guard
pages unless the VM_NO_GUARD flag is specified. However, those guard
pages are *behind* allocations, not in front of them, while a stack
guard primarily needs to be in front of the allocation. This wouldn't
matter if all allocations in the vmalloc area had guard pages behind
them, but if someone first does some data allocation with VM_NO_GUARD
and then a stack allocation directly behind that, there won't be a
guard between the data allocation and the stack allocation.

(I might be wrong though; this is only from looking at the code, not
from testing it.)
