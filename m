From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 14/16] io_uring: support kernel side submission
Date: Wed, 9 Jan 2019 13:49:01 -0700
Message-ID: <205e9c21-e524-f56d-3684-26db6e87b54e@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-15-axboe@kernel.dk> <20190109190638.GB22645@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190109190638.GB22645@lst.de>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On 1/9/19 12:06 PM, Christoph Hellwig wrote:
>> +struct iocb_submit {
>> +	const struct io_uring_iocb *iocb;
>> +	unsigned int index;
>> +};
>> +
>> +struct io_work {
>> +	struct work_struct work;
>> +	struct io_ring_ctx *ctx;
>> +	struct io_uring_iocb iocb;
>> +	unsigned iocb_index;
>> +};
> 
> I think we should use struct iocb_submit everywhere where we pass
> an iocb + index, including in the io_work structure.  Here is how
> I did that to my old tree:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/65929ed6f143a1c996305a10a15fd7f64d32595f

I like that unification.

> Btw, I think we can also remove the separate io_work allocation,
> just do the io_get_req in the submission context, and overlay
> the io_work onto the iocb in a union of some sort.  This avoids
> a whole memory allocation.

I'll take a look at that.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
