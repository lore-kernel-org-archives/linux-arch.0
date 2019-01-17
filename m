Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfAQUDo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jan 2019 15:03:44 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 05/15] Add io_uring IO interface
References: <20190116175003.17880-1-axboe@kernel.dk>
        <20190116175003.17880-6-axboe@kernel.dk>
        <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
        <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
Date: Thu, 17 Jan 2019 15:03:41 -0500
In-Reply-To: <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk> (Jens Axboe's
        message of "Thu, 17 Jan 2019 07:01:07 -0700")
Message-ID: <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190117200341.VmGIQ0TStxF2nZDum7LxYIa9hsKuCEe-cCMvWlbMNzU@z>

Jens Axboe <axboe@kernel.dk> writes:

> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>> On 2019-01-16 18:49, Jens Axboe wrote:
>> 
>> [...]
>> 
>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>> +				  struct io_uring_params *p)
>>> +{
>>> +	struct io_sq_ring *sq_ring;
>>> +	struct io_cq_ring *cq_ring;
>>> +	size_t size;
>>> +	int ret;
>>> +
>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
>> 
>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>> passing random entries number? (or even better: decreasing entries 
>> number,
>> in order to consume all pages orders with min number of loops).
>
> Yes, that's an oversight, we should have a limit in place. I'll add that.

Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd prefer
not to repeat the mistake of fs.aio-max-nr.

-Jeff
