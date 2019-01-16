Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:52106 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393958AbfAPPOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jan 2019 10:14:23 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so3474576ite.1
        for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2019 07:14:22 -0800 (PST)
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-14-axboe@kernel.dk>
 <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk>
Date: Wed, 16 Jan 2019 08:14:17 -0700
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
Message-ID: <20190116151417._FO4t_ryd5jZupuNb6GAgemKUu9tdY2wK0El3MA3aiw@z>

On 1/16/19 3:53 AM, Arnd Bergmann wrote:
> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
> 
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 542757a4c898..e36c264d74e8 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>>                                 struct io_uring_params __user *p);
>>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>>                                 u32 min_complete, u32 flags);
>> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
>> +                               void __user *arg);
>>
> 
> Would it be possible to make this a typed pointer instead? If this needs to
> be extended later to pass a different structure, a new system call may
> be better for consistency than overloading the argument in various
> ways.

As you can see from the later patch for registering files, it'll be used
for other structs too. Feels a little silly to add an extra system call
for that. I agree the void * isn't the prettiest thing in the world, but
at least it allows us to extend the API without having to add even more
system calls down the line.

>> + * io_uring_register(2) opcodes and arguments
>> + */
>> +#define IORING_REGISTER_BUFFERS                0
>> +#define IORING_UNREGISTER_BUFFERS      1
>> +
>> +struct io_uring_register_buffers {
>> +       union {
>> +               struct iovec *iovecs;
>> +               __u64 pad;
>> +       };
>> +       __u32 nr_iovecs;
>> +};
> 
> As before, I'd suggest making this structure compatible between 32-bit
> and 64-bit architectectures, by avoiding pointer and implied padding
> fields.

I'll await an answer to my previous question on that.

-- 
Jens Axboe
