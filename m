Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:39553 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfAQUJJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2019 15:09:09 -0500
Received: by mail-io1-f66.google.com with SMTP id k7so8871029iob.6
        for <linux-arch@vger.kernel.org>; Thu, 17 Jan 2019 12:09:09 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
Date: Thu, 17 Jan 2019 13:09:06 -0700
MIME-Version: 1.0
In-Reply-To: <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190117200906.YU_NiAlEVAZ8j_NLZiTcRhv46b68rJ3TiPVVwMSFX7g@z>

On 1/17/19 1:03 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>>> On 2019-01-16 18:49, Jens Axboe wrote:
>>>
>>> [...]
>>>
>>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>>> +				  struct io_uring_params *p)
>>>> +{
>>>> +	struct io_sq_ring *sq_ring;
>>>> +	struct io_cq_ring *cq_ring;
>>>> +	size_t size;
>>>> +	int ret;
>>>> +
>>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
>>>
>>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>>> passing random entries number? (or even better: decreasing entries 
>>> number,
>>> in order to consume all pages orders with min number of loops).
>>
>> Yes, that's an oversight, we should have a limit in place. I'll add that.
> 
> Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd prefer
> not to repeat the mistake of fs.aio-max-nr.

Sure, we can do that. With the ring limited in size (it's now 4k entries
at most), the amount of memory gobbled up by that is much smaller than
the fixed buffers. A max sized ring is about 256k of memory.

-- 
Jens Axboe
