From: Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH 05/15] Add io_uring IO interface
Date: Fri, 18 Jan 2019 09:23:53 +0100
Message-ID: <3189352fb5866022d782811a65022a50@suse.de>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
 <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
 <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
 <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
Sender: owner-linux-aio@kvack.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com, linux-block-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2019-01-17 21:50, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 1/17/19 1:09 PM, Jens Axboe wrote:
>>> On 1/17/19 1:03 PM, Jeff Moyer wrote:
>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>> 
>>>>> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>>>>>> On 2019-01-16 18:49, Jens Axboe wrote:
>>>>>> 
>>>>>> [...]
>>>>>> 
>>>>>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>>>>>> +				  struct io_uring_params *p)
>>>>>>> +{
>>>>>>> +	struct io_sq_ring *sq_ring;
>>>>>>> +	struct io_cq_ring *cq_ring;
>>>>>>> +	size_t size;
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, 
>>>>>>> p->sq_entries));
>>>>>> 
>>>>>> It seems that sq_entries, cq_entries are not limited at all.  Can 
>>>>>> nasty
>>>>>> app consume a lot of kernel pages calling io_setup_uring() from a 
>>>>>> loop
>>>>>> passing random entries number? (or even better: decreasing entries
>>>>>> number,
>>>>>> in order to consume all pages orders with min number of loops).
>>>>> 
>>>>> Yes, that's an oversight, we should have a limit in place. I'll add 
>>>>> that.
>>>> 
>>>> Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd 
>>>> prefer
>>>> not to repeat the mistake of fs.aio-max-nr.
>>> 
>>> Sure, we can do that. With the ring limited in size (it's now 4k 
>>> entries
>>> at most), the amount of memory gobbled up by that is much smaller 
>>> than
>>> the fixed buffers. A max sized ring is about 256k of memory.
> 
> Per io_uring.  Nothing prevents a user from calling io_uring_setup in a
> loop and continuing to gobble up memory.

What if we set a sane limit for a uring instance (not for the whole 
io_uring),
but allocate rings on mmap?  Then greedy / nasty app will be killed by 
oom.

--
Roman

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
