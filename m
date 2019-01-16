From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Date: Wed, 16 Jan 2019 08:12:29 -0700
Message-ID: <15b06ccb-4501-f104-9a3a-f028218a0d70@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-6-axboe@kernel.dk>
 <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
List-Id: linux-arch.vger.kernel.org

On 1/16/19 3:41 AM, Arnd Bergmann wrote:
> On Tue, Jan 15, 2019 at 3:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
>> index 3cf7b533b3d1..194e79c0032e 100644
>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
>> @@ -398,3 +398,5 @@
>>  384    i386    arch_prctl              sys_arch_prctl                  __ia32_compat_sys_arch_prctl
>>  385    i386    io_pgetevents           sys_io_pgetevents               __ia32_compat_sys_io_pgetevents
>>  386    i386    rseq                    sys_rseq                        __ia32_sys_rseq
>> +387    i386    io_uring_setup          sys_io_uring_setup              __ia32_compat_sys_io_uring_setup
>> +388    i386    io_uring_enter          sys_io_uring_enter              __ia32_sys_io_uring_enter
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>> index f0b1709a5ffb..453ff7a79002 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -343,6 +343,8 @@
>>  332    common  statx                   __x64_sys_statx
>>  333    common  io_pgetevents           __x64_sys_io_pgetevents
>>  334    common  rseq                    __x64_sys_rseq
>> +335    common  io_uring_setup          __x64_sys_io_uring_setup
>> +336    common  io_uring_enter          __x64_sys_io_uring_enter
> 
> In my series for the y2038 system calls, I'm trying to move to having the
> same numbers across all architectures. Unfortunately, that clashes
> with newly assigned numbers here, so one of us needs to pick new
> numbers.
> 
> If my series gets merged without other changes to the numbers, the next
> available numbers on all architectures become 424 and 425.
> 
> Could you use those here?

Yeah that's totally fine, I don't really care what the numbers end up
being, that side isn't fixed for me.

>> +SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>> +               struct io_uring_params __user *, params)
>> +{
>> +       return io_uring_setup(entries, params, false);
>> +}
>> +
>> +#ifdef CONFIG_COMPAT
>> +COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>> +                      struct io_uring_params __user *, params)
>> +{
>> +       return io_uring_setup(entries, params, true);
>> +}
>> +#endif
> 
> The compat syscall has the same calling conventions as the
> native one here, so I think you can just use that directly.

Not sure I understand what you mean here. I need to know if it's the
compat one, hence 'true' vs 'false', so I know what the size of the user
pointers/structs are.

>> +/*
>> + * IO submission data structure (Submission Queue Entry)
>> + */
>> +struct io_uring_sqe {
>> +       __u8    opcode;         /* type of operation for this sqe */
>> +       __u8    flags;          /* as of now unused */
>> +       __u16   ioprio;         /* ioprio for the request */
>> +       __s32   fd;             /* file descriptor to do IO on */
>> +       __u64   off;            /* offset into file */
>> +       union {
>> +               void    *addr;  /* buffer or iovecs */
>> +               __u64   __pad;
>> +       };
> 
> It seems a bit unfortunate to keep the pointer field only
> almost compatible between 32-bit and 64-bit big-endian
> architectures, as that requires an in_compat_syscall()
> check whenever we access the pointer from the kernel.
> 
> Could you use a __u64 field to store the pointer itself
> instead?

I feel like I'm missing something here, we'll still need the compat code
on the kernel side for 32-bit app on 64-bit kernel, so what would we
solve by making this an __u64?

>> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>> index ab9d0e3c6d50..ee5e523564bb 100644
>> --- a/kernel/sys_ni.c
>> +++ b/kernel/sys_ni.c
>> @@ -46,6 +46,8 @@ COND_SYSCALL(io_getevents);
>>  COND_SYSCALL(io_pgetevents);
>>  COND_SYSCALL_COMPAT(io_getevents);
>>  COND_SYSCALL_COMPAT(io_pgetevents);
>> +COND_SYSCALL(io_uring_setup);
>> +COND_SYSCALL(io_uring_enter);
> 
> Unless you remove the compat_sys_io_uring_setup() definition,
> this should also have a corresponding COND_SYSCALL_COMPAT()
> entry.

Gotcha, thanks! I'll make that change.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
