Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42120 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeGKVNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jul 2018 17:13:49 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so51854220oib.9
        for <linux-arch@vger.kernel.org>; Wed, 11 Jul 2018 14:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-23-yu-cheng.yu@intel.com>
In-Reply-To: <20180710222639.8241-23-yu-cheng.yu@intel.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Jul 2018 14:07:09 -0700
Message-ID: <CAG48ez0h5cabNiSBkCnAoyg9LXoSd7PpuStbRpV5r67VMHocRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/27] x86/cet/ibt: User-mode indirect branch
 tracking support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yu-cheng.yu@intel.com
Cc: the arch/x86 maintainers <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, bsingharora@gmail.com, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com, Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Message-ID: <20180711210709.z5xvL3M8AYOtqxZKvZNCVUzfQJO2h4a8v7h8gG_YO-8@z>

On Tue, Jul 10, 2018 at 3:31 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Add user-mode indirect branch tracking enabling/disabling
> and supporting routines.
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
[...]
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index 4eba7790c4e4..8bbd63e1a2ba 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
[...]
> +static unsigned long ibt_mmap(unsigned long addr, unsigned long len)
> +{
> +       struct mm_struct *mm = current->mm;
> +       unsigned long populate;
> +
> +       down_write(&mm->mmap_sem);
> +       addr = do_mmap(NULL, addr, len, PROT_READ | PROT_WRITE,
> +                      MAP_ANONYMOUS | MAP_PRIVATE,
> +                      VM_DONTDUMP, 0, &populate, NULL);
> +       up_write(&mm->mmap_sem);
> +
> +       if (populate)
> +               mm_populate(addr, populate);
> +
> +       return addr;
> +}

Is this thing going to stay writable? Will any process with an IBT
bitmap be able to disable protections by messing with the bitmap even
if the lock-out mode is active? If so, would it perhaps make sense to
forbid lock-out mode if an IBT bitmap is active, to make it clear that
effective lock-out is impossible in that state?
