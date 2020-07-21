From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
Date: Tue, 21 Jul 2020 12:59:22 +0200
Message-ID: <CAKgNAkgdOZXsVVkYveqnjODOr_cHYWiRssw2Tu1dZEBd+GnOnA@mail.gmail.com>
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgGUK7e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:59:34 -0400
In-Reply-To: <20200720092435.17469-4-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>

Hi Mike,

On Mon, 20 Jul 2020 at 11:26, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Introduce "secretmemfd" system call with the ability to create memory areas
> visible only in the context of the owning process and not mapped not only
> to other processes but in the kernel page tables as well.
>
> The user will create a file descriptor using the secretmemfd system call

Without wanting to start a bikeshed discussion, the more common
convention in recently added system calls is to use an underscore in
names that consist of multiple clearly distinct words. See many
examples in  https://man7.org/linux/man-pages/man2/syscalls.2.html.

Thus, I'd suggest at least secret_memfd().

Also, I wonder whether memfd_secret() might not be even better.
There's plenty of precedent for the naming style where related APIs
share a common prefix [1].

Thanks,

Michael

[1] Some examples:

       epoll_create(2)
       epoll_create1(2)
       epoll_ctl(2)
       epoll_pwait(2)
       epoll_wait(2)

       mq_getsetattr(2)
       mq_notify(2)
       mq_open(2)
       mq_timedreceive(2)
       mq_timedsend(2)
       mq_unlink(2)

       sched_get_affinity(2)
       sched_get_priority_max(2)
       sched_get_priority_min(2)
       sched_getaffinity(2)
       sched_getattr(2)
       sched_getparam(2)
       sched_getscheduler(2)
       sched_rr_get_interval(2)
       sched_set_affinity(2)
       sched_setaffinity(2)
       sched_setattr(2)
       sched_setparam(2)
       sched_setscheduler(2)
       sched_yield(2)

       timer_create(2)
       timer_delete(2)
       timer_getoverrun(2)
       timer_gettime(2)
       timer_settime(2)

       timerfd_create(2)
       timerfd_gettime(2)
       timerfd_settime(2)




-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
