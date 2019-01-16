Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:41549 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394087AbfAPPcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jan 2019 10:32:08 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so5169277ioc.8
        for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2019 07:32:07 -0800 (PST)
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
From: Jens Axboe <axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-14-axboe@kernel.dk>
 <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
 <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk>
Message-ID: <331f63c0-002f-b373-b831-73af9e98f2ef@kernel.dk>
Date: Wed, 16 Jan 2019 08:32:03 -0700
MIME-Version: 1.0
In-Reply-To: <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
Message-ID: <20190116153203.trONsawxgk81lMqULxgO5mIVafAtlrfMwUniKmYE1nE@z>

On 1/16/19 8:14 AM, Jens Axboe wrote:
> On 1/16/19 3:53 AM, Arnd Bergmann wrote:
>> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>> index 542757a4c898..e36c264d74e8 100644
>>> --- a/include/linux/syscalls.h
>>> +++ b/include/linux/syscalls.h
>>> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>>>                                 struct io_uring_params __user *p);
>>>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>>>                                 u32 min_complete, u32 flags);
>>> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
>>> +                               void __user *arg);
>>>
>>
>> Would it be possible to make this a typed pointer instead? If this needs to
>> be extended later to pass a different structure, a new system call may
>> be better for consistency than overloading the argument in various
>> ways.
> 
> As you can see from the later patch for registering files, it'll be used
> for other structs too. Feels a little silly to add an extra system call
> for that. I agree the void * isn't the prettiest thing in the world, but
> at least it allows us to extend the API without having to add even more
> system calls down the line.

With the __u64 changes, we end up with this:

struct io_uring_register_buffers {
	__u64 iovecs;		/* pointer to iovecs array */
	__u32 nr_iovecs;	/* number of iovecs in array */
	__u32 pad;
};

struct io_uring_register_files {
	__u64 fds;
	__u32 nr_fds;
	__u32 pad;
};

which are identical. So the question then becomes if I should just make
these opaque enough to be the same thing, ala:

struct io_uring_register_data {
	__u64 data;
	__u32 nr_elems;
	__u32 pad;
};

and then probably add a bit more reserved space so we have something
that can be extended...

-- 
Jens Axboe
