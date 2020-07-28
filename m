Return-Path: <SRS0=h896=BH=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <46891e3b-ca08-197d-935f-fa0a52a60051@virtuozzo.com>
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Message-ID: <e6699d15-8c86-8f9a-b840-7c3872e3ec8c@oracle.com>
Date: Tue, 28 Jul 2020 10:28:07 -0700
MIME-Version: 1.0
In-Reply-To: <46891e3b-ca08-197d-935f-fa0a52a60051@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200728172807.Iy0PSfdK2ZEz4DwHUd5_Q4ftZMzy3PuqF-7KivJQ5IY@z>



On 7/28/20 4:34 AM, Kirill Tkhai wrote:
> On 27.07.2020 20:11, Anthony Yznaga wrote:
>> This patchset adds support for preserving an anonymous memory range ac=
ross
>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit=
 for
>> sharing memory in this manner, as opposed to re-attaching to a named s=
hared
>> memory segment, is to ensure it is mapped at the same virtual address =
in
>> the new process as it was in the old one.  An intended use for this is=
 to
>> preserve guest memory for guests using vfio while qemu exec's an updat=
ed
>> version of itself.  By ensuring the memory is preserved at a fixed add=
ress,
> So, the goal is an update of QEMU binary without a stopping of virtual =
machine?
Essentially, yes.=C2=A0 The VM is paused very briefly.

Anthony
>
>> vfio mappings and their associated kernel data structures can remain v=
alid.
>> In addition, for the qemu use case, qemu instances that back guest RAM=
 with
>> anonymous memory can be updated.
>>
>> Patches 1 and 2 ensure that loading of ELF load segments does not sile=
ntly
>> clobber existing VMAS, and remove assumptions that the stack is the on=
ly
>> VMA in the mm when the stack is set up.  Patch 1 re-introduces the use=
 of
>> MAP_FIXED_NOREPLACE to load ELF binaries that addresses the previous i=
ssues
>> and could be considered on its own.
>>
>> Patches 3, 4, and 5 introduce the feature and an opt-in method for its=
 use
>> using an ELF note.
>>
>> Anthony Yznaga (5):
>>   elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappin=
gs
>>   mm: do not assume only the stack vma exists in setup_arg_pages()
>>   mm: introduce VM_EXEC_KEEP
>>   exec, elf: require opt-in for accepting preserved mem
>>   mm: introduce MADV_DOEXEC
>>
>>  arch/x86/Kconfig                       |   1 +
>>  fs/binfmt_elf.c                        | 196 ++++++++++++++++++++++++=
+--------
>>  fs/exec.c                              |  33 +++++-
>>  include/linux/binfmts.h                |   7 +-
>>  include/linux/mm.h                     |   5 +
>>  include/uapi/asm-generic/mman-common.h |   3 +
>>  kernel/fork.c                          |   2 +-
>>  mm/madvise.c                           |  25 +++++
>>  mm/mmap.c                              |  47 ++++++++
>>  9 files changed, 266 insertions(+), 53 deletions(-)
>>
