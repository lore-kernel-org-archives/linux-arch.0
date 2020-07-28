From: Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Tue, 28 Jul 2020 14:34:37 +0300
Message-ID: <46891e3b-ca08-197d-935f-fa0a52a60051@virtuozzo.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
List-Id: linux-arch.vger.kernel.org

On 27.07.2020 20:11, Anthony Yznaga wrote:
> This patchset adds support for preserving an anonymous memory range across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> sharing memory in this manner, as opposed to re-attaching to a named shared
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address,

So, the goal is an update of QEMU binary without a stopping of virtual machine?

> vfio mappings and their associated kernel data structures can remain valid.
> In addition, for the qemu use case, qemu instances that back guest RAM with
> anonymous memory can be updated.
> 
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
> 
