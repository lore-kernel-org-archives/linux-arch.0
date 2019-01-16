Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39444 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfAPWNc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jan 2019 17:13:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so3669751pld.6
        for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2019 14:13:31 -0800 (PST)
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
From: Jens Axboe <axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk> <20190116205338.GQ4205@dastard>
 <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
Message-ID: <e0e574f0-9938-eaba-cffb-c66f754f33c5@kernel.dk>
Date: Wed, 16 Jan 2019 15:13:28 -0700
MIME-Version: 1.0
In-Reply-To: <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190116221328.mVIX2SEeKAYGCEr41BeN_6A8vhWnqVLz_WTe6cDxSWI@z>

On 1/16/19 2:20 PM, Jens Axboe wrote:
> On 1/16/19 1:53 PM, Dave Chinner wrote:
>> On Wed, Jan 16, 2019 at 10:50:00AM -0700, Jens Axboe wrote:
>>> If we have fixed user buffers, we can map them into the kernel when we
>>> setup the io_context. That avoids the need to do get_user_pages() for
>>> each and every IO.
>> .....
>>> +			return -ENOMEM;
>>> +	} while (atomic_long_cmpxchg(&ctx->user->locked_vm, cur_pages,
>>> +					new_pages) != cur_pages);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
>>> +{
>>> +	int i, j;
>>> +
>>> +	if (!ctx->user_bufs)
>>> +		return -EINVAL;
>>> +
>>> +	for (i = 0; i < ctx->sq_entries; i++) {
>>> +		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
>>> +
>>> +		for (j = 0; j < imu->nr_bvecs; j++) {
>>> +			set_page_dirty_lock(imu->bvec[j].bv_page);
>>> +			put_page(imu->bvec[j].bv_page);
>>> +		}
>>
>> Hmmm, so we call set_page_dirty() when the gup reference is dropped...
>>
>> .....
>>
>>> +static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
>>> +				  unsigned nr_args)
>>> +{
>>
>> .....
>>
>>> +		down_write(&current->mm->mmap_sem);
>>> +		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
>>> +						pages, NULL);
>>> +		up_write(&current->mm->mmap_sem);
>>
>> Thought so. This has the same problem as RDMA w.r.t. using
>> file-backed mappings for the user buffer.  It is not synchronised
>> against truncate, hole punches, async page writeback cleaning the
>> page, etc, and so can lead to data corruption and/or kernel panics.
>>
>> It also can't be used with DAX because the above problems are
>> actually a user-after-free of storage space, not just a dangling
>> page reference that can be cleaned up after the gup pin is dropped.
>>
>> Perhaps, at least until we solve the GUP problems w.r.t. file backed
>> pages and/or add and require file layout leases for these reference,
>> we should error out if the  user buffer pages are file-backed
>> mappings?
> 
> Thanks for taking a look at this.
> 
> I'd be fine with that restriction, especially since it can get relaxed
> down the line. Do we have an appropriate API for this? And why isn't
> get_user_pages_longterm() that exact API already? Would seem that most
> (all?) callers of this API is currently broken then.

I guess for now I can just pass in a vmas array for
get_user_pages_longeterm() and then iterate those and check for
vma->vm_file. If it's set, then we fail the buffer registration.

And then drop the set_page_dirty() on release, we don't need that.

-- 
Jens Axboe
