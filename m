From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
Date: Wed, 16 Jan 2019 16:17:01 -0700
Message-ID: <29622208-d155-4f76-78d5-e7dd54ee807b@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk> <20190116205338.GQ4205@dastard>
 <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
 <20190116220938.GR4205@dastard>
 <7fd5cb40-2288-3c54-41d1-3163098b25ef@kernel.dk>
 <20190116230920.GT4205@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190116230920.GT4205@dastard>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On 1/16/19 4:09 PM, Dave Chinner wrote:
> On Wed, Jan 16, 2019 at 03:21:21PM -0700, Jens Axboe wrote:
>> On 1/16/19 3:09 PM, Dave Chinner wrote:
>>> On Wed, Jan 16, 2019 at 02:20:53PM -0700, Jens Axboe wrote:
>>>> On 1/16/19 1:53 PM, Dave Chinner wrote:
>>>> I'd be fine with that restriction, especially since it can get relaxed
>>>> down the line. Do we have an appropriate API for this?  And why isn't
>>>> get_user_pages_longterm() that exact API already?
>>>
>>> get_user_pages_longterm() is the right thing to use to ensure DAX
>>> doesn't trip over this - it's effectively just get_user_pages()
>>> with a "if (vma_is_fsdax(vma))" check in it to abort and return
>>> -EOPNOTSUPP. IOWs, this is safe on DAX but it's not safe on anything
>>> else. :/
>>>
>>> Unfortunately, disallowing userspace GUP pins on non-DAX file backed
>>> pages will break existing "mostly just work" userspace apps all over
>>> the place. And so right now there are discussions ongoing about how
>>> to map gup references avoid the writeback races and be able to be
>>> seen/tracked by other kernel infrastructure (see the long, long
>>> thread "[PATCH 0/2] put_user_page*(): start converting the call
>>> sites" on -fsdevel). Progress is slow, but I think we're starting to
>>> close on a workable solution.
>>>
>>> FWIW, this doesn't solve the "long term user pin will block
>>> filesystem operations until unpin" problem, that's what moving to
>>> using revocable file layout leases is intended to solve. There have
>>> been patches posted some time ago to add this user API for this, but
>>> we've got to solve the other problems first....
>>>
>>>> Would seem that most
>>>> (all?) callers of this API is currently broken then.
>>>
>>> Yup, there's a long, long history of machines using userspace RDMA
>>> panicing because filesystems have detected or tripped over invalid
>>> page cache state during writeback attempts. This is not a new
>>> problem....
>>
>> Thanks for your detailed answer, Dave! I didn't see it before I sent
>> out the previous email. FWIW, I've updated the patch:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=0c8f2299f8069af6b2fa8f99a10d81646d1237a7
>>
>> Checks for file backed memory, fails the registration with EOPNOTSUPP
>> if the check fails.
> 
> Doesn't it need to call put_pages() on all the pages picked up by
> get_user_pages_longterm() when it returns -EOPNOTSUPP? They haven't
> been mapped into the imu->bvec array yet, so AFAICT there's nothing
> to release the page references on teardown here.

Oops, yes good point. The usual error handling won't work for this, need
to put them.

> Also, not a vma expert here, but the vma array contents may only be
> valid while the mmap_sem is held - I think vmas can come and go
> after it has been dropped and so accessing vmas to check
> vma->vm_file after the mmap_sem has been dropped may be open to
> read-after-free races.

I did fix that one right after sending out the email:

http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=d2b44723d5bceeb9966c858255a03596ed62929c

I'll fix the missing put_pages() on error and update it.

>> That should handle the issue on the io_uring side at least, and it's a
>> restriction that can always be relaxed/lifted, when appropriate solutions
>> to file backed buffers exists.
> 
> Modulo the issue above, that works for me.

Great!

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
