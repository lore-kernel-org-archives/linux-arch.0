Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:51757 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfAIQ6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 11:58:02 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so12684103ite.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 08:58:02 -0800 (PST)
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-12-axboe@kernel.dk> <20190109121340.GD13779@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0a91dd38-69b8-84ab-f96a-225f09a54ec9@kernel.dk>
Date: Wed, 9 Jan 2019 09:57:59 -0700
MIME-Version: 1.0
In-Reply-To: <20190109121340.GD13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109165759.UZEsc-KWt0GFzCKqXiVVmPKKNjZh1MR-9qbwKlCiefE@z>

On 1/9/19 5:13 AM, Christoph Hellwig wrote:
>> +	if (!state)
>> +		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
> 
> Just return an error here if kmem_cache_alloc fails.
> 
>> +	if (req)
>> +		io_req_init(ctx, req);
> 
> Because all the other ones can't reached this with a NULL req.

This is different in the current tree, since I properly fixed the
ctx ref issue.

-- 
Jens Axboe
