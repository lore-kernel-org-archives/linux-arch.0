Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:35143 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfAIQ4N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 11:56:13 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so11987661itp.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 08:56:13 -0800 (PST)
Subject: Re: [PATCH 10/16] io_uring: split kiocb init from allocation
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-11-axboe@kernel.dk> <20190109121250.GC13779@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7623e628-28eb-bddf-14e7-f6bf91d639bf@kernel.dk>
Date: Wed, 9 Jan 2019 09:56:10 -0700
MIME-Version: 1.0
In-Reply-To: <20190109121250.GC13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109165610.2pbm-2pc0LXxg-xDryEDVyNhVV_RCIz3LEdG12slJbU@z>

On 1/9/19 5:12 AM, Christoph Hellwig wrote:
> On Tue, Jan 08, 2019 at 09:56:39AM -0700, Jens Axboe wrote:
>> In preparation from having pre-allocated requests, that we then just
>> need to initialize before use.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/io_uring.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index afbaebb63012..11d045f0f799 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -202,6 +202,14 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
>>  	return &ring->events[tail & ctx->cq_ring.ring_mask];
>>  }
>>  
>> +static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
>> +{
>> +	percpu_ref_get(&ctx->refs);
>> +	req->ki_ctx = ctx;
>> +	INIT_LIST_HEAD(&req->ki_list);
>> +	req->ki_flags = 0;
> 
> We still only have a single caller of this in the final tree, and
> I don't think this function helps.  So I'd just drop the patch.

Dropped

-- 
Jens Axboe
