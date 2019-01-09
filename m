Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:55077 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfAIUtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 15:49:04 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so13770351ita.4
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 12:49:03 -0800 (PST)
Subject: Re: [PATCH 14/16] io_uring: support kernel side submission
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-15-axboe@kernel.dk> <20190109190638.GB22645@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <205e9c21-e524-f56d-3684-26db6e87b54e@kernel.dk>
Date: Wed, 9 Jan 2019 13:49:01 -0700
MIME-Version: 1.0
In-Reply-To: <20190109190638.GB22645@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109204901.Nr6n68P78XY1gSAxXX3jp55__JoVGFyKEW1iv7E0Isg@z>

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
