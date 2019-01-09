From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Date: Wed, 9 Jan 2019 08:53:31 -0700
Message-ID: <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-6-axboe@kernel.dk> <20190109121030.GA13779@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190109121030.GA13779@lst.de>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On 1/9/19 5:10 AM, Christoph Hellwig wrote:
>> index 293733f61594..9ef9987b4192 100644
>> --- a/fs/Makefile
>> +++ b/fs/Makefile
>> @@ -29,7 +29,7 @@ obj-$(CONFIG_SIGNALFD)		+= signalfd.o
>>  obj-$(CONFIG_TIMERFD)		+= timerfd.o
>>  obj-$(CONFIG_EVENTFD)		+= eventfd.o
>>  obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
>> -obj-$(CONFIG_AIO)               += aio.o
>> +obj-$(CONFIG_AIO)               += aio.o io_uring.o
> 
> It is probablt worth adding a new config symbol for the uring as no
> code is shared with aio.

Agreed, done.

>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> new file mode 100644
>> index 000000000000..ae2b886282bb
>> --- /dev/null
>> +++ b/fs/io_uring.c
>> @@ -0,0 +1,849 @@
>> +/*
>> + * Shared application/kernel submission and completion ring pairs, for
>> + * supporting fast/efficient IO.
>> + *
>> + * Copyright (C) 2019 Jens Axboe
>> + */
> 
> Add an SPDX header to all new files, please.

Done

>> +struct io_sq_ring {
>> +	struct io_uring		r;
>> +	u32			ring_mask;
>> +	u32			ring_entries;
>> +	u32			dropped;
>> +	u32			flags;
>> +	u32			array[0];
>> +};
> 
> field[0] is a legacy gcc extension, the proper C99+ way is field[].

Fixed

>> +struct io_iocb_ring {
>> +	struct			io_sq_ring *ring;
>> +	unsigned		entries;
>> +	unsigned		ring_mask;
>> +	struct io_uring_iocb	*iocbs;
>> +};
>> +
>> +struct io_event_ring {
>> +	struct io_cq_ring	*ring;
>> +	unsigned		entries;
>> +	unsigned		ring_mask;
>> +};
> 
> Btw, do we really need there structures?  It would seem simpler
> to just embedd them into the containing structure as:
> 
> 	struct io_sq_ring	*sq_ring;
> 	unsigned		sq_ring_entries;
> 	unsigned		sq_ring_mask;
> 	struct io_uring_iocb	*sq_ring_iocbs;
> 
> 	struct io_cq_ring	*cq_ring;
> 	unsigned		cq_ring_entries;
> 	unsigned		cq_ring_mask;

Yeah, I guess we use it directly in so few places that we may as well
just get rid of the structs for these.

> 	
> 
>> +struct io_ring_ctx {
>> +	struct percpu_ref	refs;
>> +
>> +	unsigned int		flags;
>> +	unsigned int		max_reqs;
> 
> max_reqs can probably go away in favour of the sq ring nr_entries
> field.

Indeed, killed.

>> +	struct io_iocb_ring	sq_ring;
>> +	struct io_event_ring	cq_ring;
>> +
>> +	struct work_struct	work;
>> +
>> +	struct {
>> +		struct mutex uring_lock;
>> +	} ____cacheline_aligned_in_smp;
>> +
>> +	struct {
>> +		struct mutex    ring_lock;
>> +		wait_queue_head_t wait;
>> +	} ____cacheline_aligned_in_smp;
>> +
>> +	struct {
>> +		spinlock_t      completion_lock;
>> +	} ____cacheline_aligned_in_smp;
>> +};
> 
> Can you take a deep look if we need to keep all of ring_lock,
> completion_lock and the later added poll locking?  From a quick look
> is isn't entirely clear what the locking strategy on the completion
> side is.  It needs to be documented and can hopefully be simplified.

I think we just need to kill ring_lock, it's actually not even used.
I'll take a closer look at the locking as well.

> 
>> +struct fsync_iocb {
>> +	struct work_struct	work;
>> +	struct file		*file;
>> +	bool			datasync;
>> +};
> 
> Do we actually need this?  Can't we just reuse the later thread
> offload for fsync?  Maybe just add fsync support once everything else
> is done to make that simpler.

We can just use the sq thread, but we don't always have that backing. I
guess we could create it lazily if an fsync comes in. I'll take a look
at adding that as a separate thing.

>> +static const struct file_operations io_scqring_fops;
>> +
>> +static void io_ring_ctx_free(struct work_struct *work);
>> +static void io_ring_ctx_ref_free(struct percpu_ref *ref);
> 
> Can you try to avoid to need the forward delcaration?  (except for the
> fops, where we probably need it).

I got rid of one of them in my current tree already, I'll see if I can
dump the other one.

>> +static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>> +{
>> +	struct io_ring_ctx *ctx;
>> +
>> +	ctx = kmem_cache_zalloc(ioctx_cachep, GFP_KERNEL);
>> +	if (!ctx)
>> +		return NULL;
> 
> Do we really need an explicit slab for the contexts?

Not sure, guess it depends on the frequency of them. But I suspect that
it won't matter one bit, I'll kill this slab.

> 
>> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
> 
> Maybe replace the req name with something matching the structure
> name?  (and more on the structure name later).

Make sense.

>> +{
>> +	struct io_kiocb *req;
>> +
>> +	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
>> +	if (!req)
>> +		return NULL;
>> +
>> +	percpu_ref_get(&ctx->refs);
>> +	req->ki_ctx = ctx;
>> +	INIT_LIST_HEAD(&req->ki_list);
> 
> We never do a list_empty ceck on ki_list, so there should be no need
> to initialize it.

Killed

>> +static void io_fill_event(struct io_uring_event *ev, struct io_kiocb *kiocb,
>> +			  long res, unsigned flags)
>> +{
>> +	ev->index = kiocb->ki_index;
>> +	ev->res = res;
>> +	ev->flags = flags;
>> +}
> 
> Probably no need for this helper.

Killed. Also realized that we're missing a store ordering barrier after
filling in 'ev', but before incrementing the ring.

>> +static void io_complete_scqring(struct io_kiocb *iocb, long res, unsigned flags)
>> +{
>> +	io_cqring_fill_event(iocb, res, flags);
>> +	io_complete_iocb(iocb->ki_ctx, iocb);
>> +}
> 
> Probably no need for this helper either.

Killed

> 
>> +	ret = kiocb_set_rw_flags(req, iocb->rw_flags);
>> +	if (unlikely(ret))
>> +		goto out_fput;
>> +
>> +	/* no one is going to poll for this I/O */
>> +	req->ki_flags &= ~IOCB_HIPRI;
> 
> Now that we don't have the aio legacy to deal with should we just
> reject IOCB_HIPRI on a non-polled context?

Yes I think so, we don't have any legacy behavior to adhere to.

> 
>> +static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
>> +		       struct iovec **iovec, struct iov_iter *iter)
>> +{
>> +	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
>> +	size_t ret;
>> +
>> +	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>> +	*iovec = NULL;
>> +	return ret;
>> +}
> 
> Is there any point in supporting non-vectored operations here?

Not sure I follow?

>> +		if (S_ISREG(file_inode(file)->i_mode)) {
>> +			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
>> +			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
>> +		}
> 
> Overly long lines.

Fixed

>> +static int __io_submit_one(struct io_ring_ctx *ctx,
>> +			   const struct io_uring_iocb *iocb,
>> +			   unsigned long ki_index)
> 
> Maybe calls this io_ring_submit_one?  Or generally find a nice prefix
> for all the functions in this file?

Agree, some of this is leftover cruft from the aio side. I'll clean it
up.

>> +	f = fdget(fd);
>> +	if (f.file) {
>> +		struct io_ring_ctx *ctx;
> 
> Please just return early on fialure instead of forcing another level
> of indentation.

Sure, done.

> 
>> +
>> +	ctx->sq_ring.iocbs = io_mem_alloc(sizeof(struct io_uring_iocb) *
>> +						p->sq_entries);
> 
> Use array_size().

Done

>> +/*
>> + * sys_io_uring_setup:
>> + *	Sets up an aio uring context, and returns the fd. Applications asks
>> + *	for a ring size, we return the actual sq/cq ring sizes (among other
>> + *	things) in the params structure passed in.
>> + */
> 
> Can we drop this odd aio-style comment format?  In fact the syscall
> documentation probably just belongs into the man page only anyway.
> 
> Same for the uring_enter syscall.

Sure, not a big deal to me, dropped.

>> +struct io_uring_iocb {
> 
> Should we just call this io_uring_sqe?
> 
>> +/*
>> + * IO completion data structure
>> + */
>> +struct io_uring_event {
>> +	__u64	index;		/* what iocb this event came from */
>> +	__s32	res;		/* result code for this event */
>> +	__u32	flags;
>> +};
> 
> io_uring_cqe?

I'm fine with that, I like the symmetry of the names.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
