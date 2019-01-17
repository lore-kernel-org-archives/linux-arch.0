Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34595 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfAQOBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2019 09:01:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so4799566plz.1
        for <linux-arch@vger.kernel.org>; Thu, 17 Jan 2019 06:01:12 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
Date: Thu, 17 Jan 2019 07:01:07 -0700
MIME-Version: 1.0
In-Reply-To: <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roman Penyaev <rpenyaev@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190117140107.CS9jm1zIgaE-NmLF1rdsEO-leliSxyZ8-CutJRuu9p8@z>

On 1/17/19 5:48 AM, Roman Penyaev wrote:
> On 2019-01-16 18:49, Jens Axboe wrote:
> 
> [...]
> 
>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>> +				  struct io_uring_params *p)
>> +{
>> +	struct io_sq_ring *sq_ring;
>> +	struct io_cq_ring *cq_ring;
>> +	size_t size;
>> +	int ret;
>> +
>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
> 
> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
> app consume a lot of kernel pages calling io_setup_uring() from a loop
> passing random entries number? (or even better: decreasing entries 
> number,
> in order to consume all pages orders with min number of loops).

Yes, that's an oversight, we should have a limit in place. I'll add that.

-- 
Jens Axboe
