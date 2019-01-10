From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 03/16] block: add bio_set_polled() helper
Date: Thu, 10 Jan 2019 09:05:23 -0700
Message-ID: <f1a6ae88-1436-e947-1124-41e10b3ea9bc@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-4-axboe@kernel.dk> <20190110094355.GA13512@ming.t460p>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110094355.GA13512@ming.t460p>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On 1/10/19 2:43 AM, Ming Lei wrote:
> On Tue, Jan 08, 2019 at 09:56:32AM -0700, Jens Axboe wrote:
>> For the upcoming async polled IO, we can't sleep allocating requests.
>> If we do, then we introduce a deadlock where the submitter already
>> has async polled IO in-flight, but can't wait for them to complete
>> since polled requests must be active found and reaped.
>>
>> Utilize the helper in the blockdev DIRECT_IO code.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c      |  4 ++--
>>  include/linux/bio.h | 14 ++++++++++++++
>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 5415579f3e14..2ebd2a0d7789 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -233,7 +233,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>  		task_io_account_write(ret);
>>  	}
>>  	if (iocb->ki_flags & IOCB_HIPRI)
>> -		bio.bi_opf |= REQ_HIPRI;
>> +		bio_set_polled(&bio, iocb);
>>  
>>  	qc = submit_bio(&bio);
>>  	for (;;) {
>> @@ -401,7 +401,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>  		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
>>  		if (!nr_pages) {
>>  			if (iocb->ki_flags & IOCB_HIPRI)
>> -				bio->bi_opf |= REQ_HIPRI;
>> +				bio_set_polled(bio, iocb);
>>  
>>  			qc = submit_bio(bio);
>>  			WRITE_ONCE(iocb->ki_cookie, qc);
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 7380b094dcca..f6f0a2b3cbc8 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -823,5 +823,19 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
>>  
>>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>>  
>> +/*
>> + * Mark a bio as polled. Note that for async polled IO, the caller must
>> + * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
>> + * We cannot block waiting for requests on polled IO, as those completions
>> + * must be found by the caller. This is different than IRQ driven IO, where
>> + * it's safe to wait for IO to complete.
>> + */
>> +static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>> +{
>> +	bio->bi_opf |= REQ_HIPRI;
>> +	if (!is_sync_kiocb(kiocb))
>> +		bio->bi_opf |= REQ_NOWAIT;
>> +}
>> +
> 
> REQ_NOWAIT doesn't cover allocating split bio, is that a issue?

Yes, that might be an issue. I'll look into what we should do about that,
for now it's not a huge problem.

> BTW, could you explain a bit about the deadlock in case of sleep from
> request allocation?

It's more a live lock I guess, but the issue is that with polled IO, we don't
get an IRQ. For normal IO, if you run out, you can just sleep and wait for
an IRQ to come in, trigger a completion (or multiple), which will then wake
you up. For polled IO, you have to find those completions. Hence if you just
go to sleep, nobody is going to find those completions for you. You'll then
be waiting forever for an event, that will never trigger.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
