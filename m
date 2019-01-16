From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
Date: Wed, 16 Jan 2019 08:47:27 -0700
Message-ID: <c5eb06f0-b8ab-81a3-9e79-b31454211a60@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-14-axboe@kernel.dk>
 <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
 <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk>
 <331f63c0-002f-b373-b831-73af9e98f2ef@kernel.dk>
 <CAK8P3a2E8dLoL5sgucp=-LDkGMN=qnG8M_phHoHCBg5ipWgBjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <CAK8P3a2E8dLoL5sgucp=-LDkGMN=qnG8M_phHoHCBg5ipWgBjQ@mail.gmail.com>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
List-Id: linux-arch.vger.kernel.org

On 1/16/19 8:41 AM, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 4:32 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/16/19 8:14 AM, Jens Axboe wrote:
>>> On 1/16/19 3:53 AM, Arnd Bergmann wrote:
>>>> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>>>> index 542757a4c898..e36c264d74e8 100644
>>>>> --- a/include/linux/syscalls.h
>>>>> +++ b/include/linux/syscalls.h
>>>>> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>>>>>                                 struct io_uring_params __user *p);
>>>>>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>>>>>                                 u32 min_complete, u32 flags);
>>>>> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
>>>>> +                               void __user *arg);
>>>>>
>>>>
>>>> Would it be possible to make this a typed pointer instead? If this needs to
>>>> be extended later to pass a different structure, a new system call may
>>>> be better for consistency than overloading the argument in various
>>>> ways.
>>>
>>> As you can see from the later patch for registering files, it'll be used
>>> for other structs too. Feels a little silly to add an extra system call
>>> for that. I agree the void * isn't the prettiest thing in the world, but
>>> at least it allows us to extend the API without having to add even more
>>> system calls down the line.
>>
>> With the __u64 changes, we end up with this:
>>
>> struct io_uring_register_buffers {
>>         __u64 iovecs;           /* pointer to iovecs array */
>>         __u32 nr_iovecs;        /* number of iovecs in array */
>>         __u32 pad;
>> };
>>
>> struct io_uring_register_files {
>>         __u64 fds;
>>         __u32 nr_fds;
>>         __u32 pad;
>> };
>>
>> which are identical. So the question then becomes if I should just make
>> these opaque enough to be the same thing, ala:
>>
>> struct io_uring_register_data {
>>         __u64 data;
>>         __u32 nr_elems;
>>         __u32 pad;
>> };
> 
> Right, that looks good in either form.
> 
>> and then probably add a bit more reserved space so we have something
>> that can be extended...
> 
> Or maybe go the opposite way and pass the two members you have
> directly to the system call:
> 
> int io_uring_register(unsigned int fd, unsigned int opcode, void
> __user *, arg, unsigned count)
> {
>       ...
> }
> 
> Where 'arg' now points to the array of iovecs or the the array of file
> descriptors, or whatever else you need.

I kind of like that, that gets rid of having to wrap it in a struct. If
I later wanted to abuse it, arg could point to a struct...

I'll make this change.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
