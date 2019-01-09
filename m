Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:36361 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAIUIU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 15:08:20 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so12933729itj.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 12:08:20 -0800 (PST)
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-12-axboe@kernel.dk> <20190109121340.GD13779@lst.de>
 <0a91dd38-69b8-84ab-f96a-225f09a54ec9@kernel.dk>
 <20190109190321.GA22645@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <68c5faf6-913b-e94f-ccf7-a1fe158091f7@kernel.dk>
Date: Wed, 9 Jan 2019 13:08:17 -0700
MIME-Version: 1.0
In-Reply-To: <20190109190321.GA22645@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109200817.xRwotc1Ke5K3jTdJ-XdQv17YKbCMH1lF1H20UomPfbk@z>

On 1/9/19 12:03 PM, Christoph Hellwig wrote:
> On Wed, Jan 09, 2019 at 09:57:59AM -0700, Jens Axboe wrote:
>> On 1/9/19 5:13 AM, Christoph Hellwig wrote:
>>>> +	if (!state)
>>>> +		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
>>>
>>> Just return an error here if kmem_cache_alloc fails.
>>>
>>>> +	if (req)
>>>> +		io_req_init(ctx, req);
>>>
>>> Because all the other ones can't reached this with a NULL req.
>>
>> This is different in the current tree, since I properly fixed the
>> ctx ref issue.
> 
> Your tree does a percpu_ref_tryget very first, and then leaks that if
> kmem_cache_alloc_bulk fails, and also is inconsistent for NULL vs
> ERR_PTR returns.  I think you want something like this on top:

I fixed it up while doing the rebase already. Just haven't pushed anything
out until I've had a chance to run it through testing.

-- 
Jens Axboe
