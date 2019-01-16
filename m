Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:37965 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbfAPPZ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jan 2019 10:25:26 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so3175783ith.3
        for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2019 07:25:25 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-6-axboe@kernel.dk>
 <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
 <15b06ccb-4501-f104-9a3a-f028218a0d70@kernel.dk>
 <CAK8P3a2MuO-wRjYxscP-AOAUjwg6fHRc99Am6xqUmXYrJRt44w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6713aff7-115b-bb94-fb8c-b4fac86247f1@kernel.dk>
Date: Wed, 16 Jan 2019 08:25:21 -0700
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2MuO-wRjYxscP-AOAUjwg6fHRc99Am6xqUmXYrJRt44w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
Message-ID: <20190116152521.Xe-KSkRTAQTBhOudv5Qv9W4o6yGuASk1QMYarkQBfso@z>

On 1/16/19 8:16 AM, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 4:12 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/16/19 3:41 AM, Arnd Bergmann wrote:
>>> On Tue, Jan 15, 2019 at 3:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
>>>> index 3cf7b533b3d1..194e79c0032e 100644
>>>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
>>>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
>>>> +SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>>>> +               struct io_uring_params __user *, params)
>>>> +{
>>>> +       return io_uring_setup(entries, params, false);
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_COMPAT
>>>> +COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>>>> +                      struct io_uring_params __user *, params)
>>>> +{
>>>> +       return io_uring_setup(entries, params, true);
>>>> +}
>>>> +#endif
>>>
>>> The compat syscall has the same calling conventions as the
>>> native one here, so I think you can just use that directly.
>>
>> Not sure I understand what you mean here. I need to know if it's the
>> compat one, hence 'true' vs 'false', so I know what the size of the user
>> pointers/structs are.
> 
> My mistake, I missed the true/false difference between the two
> functions.
> 
>>>> +/*
>>>> + * IO submission data structure (Submission Queue Entry)
>>>> + */
>>>> +struct io_uring_sqe {
>>>> +       __u8    opcode;         /* type of operation for this sqe */
>>>> +       __u8    flags;          /* as of now unused */
>>>> +       __u16   ioprio;         /* ioprio for the request */
>>>> +       __s32   fd;             /* file descriptor to do IO on */
>>>> +       __u64   off;            /* offset into file */
>>>> +       union {
>>>> +               void    *addr;  /* buffer or iovecs */
>>>> +               __u64   __pad;
>>>> +       };
>>>
>>> It seems a bit unfortunate to keep the pointer field only
>>> almost compatible between 32-bit and 64-bit big-endian
>>> architectures, as that requires an in_compat_syscall()
>>> check whenever we access the pointer from the kernel.
>>>
>>> Could you use a __u64 field to store the pointer itself
>>> instead?
>>
>> I feel like I'm missing something here, we'll still need the compat code
>> on the kernel side for 32-bit app on 64-bit kernel, so what would we
>> solve by making this an __u64?
> 
> It means you don't have to define a compat_io_uring_sqe
> structure with a compat_uptr_t member in it.

Yeah, I finally got it, I'm making the change. Thanks!

-- 
Jens Axboe
