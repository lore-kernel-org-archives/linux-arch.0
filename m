Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36151 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbdHJTnF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2017 15:43:05 -0400
Received: by mail-it0-f45.google.com with SMTP id 77so18512346itj.1
        for <linux-arch@vger.kernel.org>; Thu, 10 Aug 2017 12:43:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170810184616.22726-1-avagin@openvz.org>
References: <20170810184616.22726-1-avagin@openvz.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 10 Aug 2017 21:42:44 +0200
Message-ID: <CAG48ez2Q+rTWUB_VfLhCFvawXLigpJXVxoNgZ28UhS+vHu_vdg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] vm: add a syscall to map a process memory into a pipe
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrei Vagin <avagin@openvz.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, criu@openvz.org, Arnd Bergmann <arnd@arndb.de>, Pavel Emelyanov <xemul@virtuozzo.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170810194244.TfmM5waD7HHMDdC7u8rVTtFEwWM22pJY764DTxLqz6I@z>

On Thu, Aug 10, 2017 at 8:46 PM, Andrei Vagin <avagin@openvz.org> wrote:
> It is a hybrid of process_vm_readv() and vmsplice().
>
> vmsplice can map memory from a current address space into a pipe.
> process_vm_readv can read memory of another process.
[...]
> +/*
> + * Map pages from a specified task into a pipe
> + */
> +static int remote_single_vec_to_pipe(struct task_struct *task,
> +                       struct mm_struct *mm,
> +                       const struct iovec *rvec,
> +                       struct pipe_inode_info *pipe,
> +                       unsigned int flags,
> +                       size_t *total)
> +{
> +       struct pipe_buffer buf = {
> +               .ops = &user_page_pipe_buf_ops,
> +               .flags = flags
> +       };
[...]
> +       while (nr_pages) {
[...]
> +               /*
> +                * Get the pages we're interested in.  We must
> +                * access remotely because task/mm might not
> +                * current/current->mm
> +                */
> +               down_read(&mm->mmap_sem);
> +               pages = get_user_pages_remote(task, mm, pa, pages, flags,
> +                                             process_pages, NULL, &locked);

This fifth "flags" argument of get_user_pages_remote() should contain
GUP flags (FOLL_*), but it looks like you're actually passing in 0 or
PIPE_BUF_FLAG_GIFT, which will be interpreted as FOLL_GET?
(See the snippets quoted below.) This looks like a bug.

Maybe use a more meaningful variable name than "flags".

> +static ssize_t remote_iovec_to_pipe(struct task_struct *task,
> +                       struct mm_struct *mm,
> +                       const struct iovec *rvec,
> +                       unsigned long riovcnt,
> +                       struct pipe_inode_info *pipe,
> +                       unsigned int flags)
> +{
[...]
> +               ret = remote_single_vec_to_pipe(
> +                               task, mm, &rvec[i], pipe, flags, &total);
[...]
> +}
> +
> +static long process_vmsplice_to_pipe(struct task_struct *task,
> +                               struct mm_struct *mm, struct file *file,
> +                               const struct iovec __user *uiov,
> +                               unsigned long nr_segs, unsigned int flags)
> +{
[...]
> +       unsigned int buf_flag = 0;
[...]
> +       if (flags & SPLICE_F_GIFT)
> +               buf_flag = PIPE_BUF_FLAG_GIFT;
[...]
> +       if (!ret)
> +               ret = remote_iovec_to_pipe(task, mm, iov,
> +                                               nr_segs, pipe, buf_flag);
[...]
> +}
