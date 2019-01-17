Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:50443 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbfAQUOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2019 15:14:12 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so3458581iti.0
        for <linux-arch@vger.kernel.org>; Thu, 17 Jan 2019 12:14:11 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
From: Jens Axboe <axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
 <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
Message-ID: <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
Date: Thu, 17 Jan 2019 13:14:09 -0700
MIME-Version: 1.0
In-Reply-To: <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190117201409.Mp98k3FtkxyGaslTEAS2wJFIeqK_K1CBGZADpb3AeyQ@z>

On 1/17/19 1:09 PM, Jens Axboe wrote:
> On 1/17/19 1:03 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>>>> On 2019-01-16 18:49, Jens Axboe wrote:
>>>>
>>>> [...]
>>>>
>>>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>>>> +				  struct io_uring_params *p)
>>>>> +{
>>>>> +	struct io_sq_ring *sq_ring;
>>>>> +	struct io_cq_ring *cq_ring;
>>>>> +	size_t size;
>>>>> +	int ret;
>>>>> +
>>>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
>>>>
>>>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>>>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>>>> passing random entries number? (or even better: decreasing entries 
>>>> number,
>>>> in order to consume all pages orders with min number of loops).
>>>
>>> Yes, that's an oversight, we should have a limit in place. I'll add that.
>>
>> Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd prefer
>> not to repeat the mistake of fs.aio-max-nr.
> 
> Sure, we can do that. With the ring limited in size (it's now 4k entries
> at most), the amount of memory gobbled up by that is much smaller than
> the fixed buffers. A max sized ring is about 256k of memory.

One concern here is that, at least looking at my boxes, the default
setting for RLIMIT_MEMLOCK is really low. I'd hate for everyone to run
into issues using io_uring just because it seems to require root,
because the memlock limit is so low.

That's much less of a concern with the fixed buffers, since it's a more
esoteric part of it. But everyone should be able to setup a few io_uring
queues and use them without having to worry about failing due to an
absurdly low RLIMIT_MEMLOCK.

Comments?

-- 
Jens Axboe
