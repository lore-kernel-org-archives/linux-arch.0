From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 06/16] io_uring: support for IO polling
Date: Wed, 9 Jan 2019 08:53:58 -0700
Message-ID: <06e3d163-7a02-96d7-d4e1-d3a37e633192@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-7-axboe@kernel.dk> <20190109121157.GB13779@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190109121157.GB13779@lst.de>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On 1/9/19 5:11 AM, Christoph Hellwig wrote:
> On Tue, Jan 08, 2019 at 09:56:35AM -0700, Jens Axboe wrote:
>> Add polled variants of the read and write commands. These act like their
>> non-polled counterparts, except we expect to poll for completion of
>> them.
> 
> These aren't really need command variants, but a different type of context.

That is phrased poorly, I'll fix that.

>>  	case IORING_OP_FSYNC:
>> +		if (ctx->flags & IORING_SETUP_IOPOLL)
>> +			break;
>>  		ret = io_fsync(&req->fsync, iocb, false);
>>  		break;
>>  	case IORING_OP_FDSYNC:
>> +		if (ctx->flags & IORING_SETUP_IOPOLL)
>> +			break;
>>  		ret = io_fsync(&req->fsync, iocb, true);
> 
> I'd move this check into io_fsync to avoid a little duplication.

Done

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
