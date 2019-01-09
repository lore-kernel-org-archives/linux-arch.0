From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
Date: Wed, 9 Jan 2019 09:57:59 -0700
Message-ID: <0a91dd38-69b8-84ab-f96a-225f09a54ec9@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-12-axboe@kernel.dk> <20190109121340.GD13779@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190109121340.GD13779@lst.de>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
