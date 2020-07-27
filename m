From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Mon, 27 Jul 2020 12:07:53 -0500
Message-ID: <87pn8glwd2.fsf@x220.int.ebiederm.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:49706 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgG0RLQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 13:11:16 -0400
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
        (Anthony Yznaga's message of "Mon, 27 Jul 2020 10:11:22 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com

Anthony Yznaga <anthony.yznaga@oracle.com> writes:

> This patchset adds support for preserving an anonymous memory range across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> sharing memory in this manner, as opposed to re-attaching to a named shared
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address,
> vfio mappings and their associated kernel data structures can remain valid.
> In addition, for the qemu use case, qemu instances that back guest RAM with
> anonymous memory can be updated.

What is wrong with using a file descriptor to a possibly deleted file
and re-mmaping it?

There is already MAP_FIXED that allows you to ensure you have the same
address.

I think all it would take would be a small protocol from one version
to the next to say map file descriptor #N and address #A.  Something
easily passed on the command line.

There is just enough complexity in exec currently that our
implementation of exec is already teetering.  So if we could use
existing mechanisms it would be good.

And I don't see why this version of sharing a mmap area would be
particularly general.  I do imagine that being able to force a
mmap area into a setuid executable would be a fun attack vector.

Perhaps I missed this in my skim of these patches but I did not see
anything that guarded this feature against an exec that changes an
applications privileges.

Eric


> Patches 1 and 2 ensure that loading of ELF load segments does not silently
> clobber existing VMAS, and remove assumptions that the stack is the only
> VMA in the mm when the stack is set up.  Patch 1 re-introduces the use of
> MAP_FIXED_NOREPLACE to load ELF binaries that addresses the previous issues
> and could be considered on its own.
>
> Patches 3, 4, and 5 introduce the feature and an opt-in method for its use
> using an ELF note.
>
> Anthony Yznaga (5):
>   elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
>   mm: do not assume only the stack vma exists in setup_arg_pages()
>   mm: introduce VM_EXEC_KEEP
>   exec, elf: require opt-in for accepting preserved mem
>   mm: introduce MADV_DOEXEC
>
>  arch/x86/Kconfig                       |   1 +
>  fs/binfmt_elf.c                        | 196 +++++++++++++++++++++++++--------
>  fs/exec.c                              |  33 +++++-
>  include/linux/binfmts.h                |   7 +-
>  include/linux/mm.h                     |   5 +
>  include/uapi/asm-generic/mman-common.h |   3 +
>  kernel/fork.c                          |   2 +-
>  mm/madvise.c                           |  25 +++++
>  mm/mmap.c                              |  47 ++++++++
>  9 files changed, 266 insertions(+), 53 deletions(-)
