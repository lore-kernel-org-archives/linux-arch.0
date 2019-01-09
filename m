From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
Date: Wed, 9 Jan 2019 10:06:35 -0700
Message-ID: <8c6797e8-c517-3d03-0837-ad68a729a733@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-14-axboe@kernel.dk> <20190109121638.GE13779@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190109121638.GE13779@lst.de>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On 1/9/19 5:16 AM, Christoph Hellwig wrote:
>> +static int io_setup_rw(int rw, struct io_kiocb *kiocb,
>> +		       const struct io_uring_iocb *iocb, struct iovec **iovec,
>> +		       struct iov_iter *iter, bool kaddr)
>>  {
>>  	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
>>  	size_t ret;
>>  
>> -	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>> +	if (!kaddr) {
>> +		ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>> +	} else {
>> +		struct io_ring_ctx *ctx = kiocb->ki_ctx;
>> +		struct io_mapped_ubuf *imu;
>> +		size_t len = iocb->len;
>> +		size_t offset;
>> +		int index;
>> +
>> +		/* __io_submit_one() already validated the index */
>> +		index = array_index_nospec(kiocb->ki_index,
>> +						ctx->max_reqs);
>> +		imu = &ctx->user_bufs[index];
>> +		if ((unsigned long) iocb->addr < imu->ubuf ||
>> +		    (unsigned long) iocb->addr + len > imu->ubuf + imu->len) {
>> +			ret = -EFAULT;
>> +			goto err;
>> +		}
>> +
>> +		/*
>> +		 * May not be a start of buffer, set size appropriately
>> +		 * and advance us to the beginning.
>> +		 */
>> +		offset = (unsigned long) iocb->addr - imu->ubuf;
>> +		iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs,
>> +				offset + len);
>> +		if (offset)
>> +			iov_iter_advance(iter, offset);
>> +		ret = 0;
>> +
> 
> Please split this code in a separate helper.

Done

>>  	if (unlikely(!file->f_op->read_iter))
>>  		goto out_fput;
>>  
>> -	ret = io_setup_rw(READ, iocb, &iovec, &iter);
>> +	ret = io_setup_rw(READ, kiocb, iocb, &iovec, &iter, kaddr);
> 
> And I'd personally just call that helper here based on the opcode and
> avoid magic bool arguments.

Then we can also fold the switch cases, cleans it up.

>> +		down_write(&current->mm->mmap_sem);
>> +		pret = get_user_pages(ubuf, nr_pages, 1, pages, NULL);
>> +		up_write(&current->mm->mmap_sem);
> 
> This needs to be get_user_pages_longterm.

Done

>> +	 * We don't use the iovecs without fixed buffers being asked for.
>> +	 * Error out if they don't match.
>> +	 */
>> +	if (!(p->flags & IORING_SETUP_FIXEDBUFS) && iovecs)
>> +		return -EINVAL;
> 
> I don't think we need the IORING_SETUP_FIXEDBUFS flag at all, as a
> non-zero iovecs pointer is enough of an indication.

Good point, no point in that redundancy. Fixed.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
