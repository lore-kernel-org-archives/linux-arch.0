Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:52052 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbfAIPyB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 10:54:01 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so12355475ite.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 07:54:00 -0800 (PST)
Subject: Re: [PATCH 06/16] io_uring: support for IO polling
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-7-axboe@kernel.dk> <20190109121157.GB13779@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <06e3d163-7a02-96d7-d4e1-d3a37e633192@kernel.dk>
Date: Wed, 9 Jan 2019 08:53:58 -0700
MIME-Version: 1.0
In-Reply-To: <20190109121157.GB13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109155358.ObnQYYq7jqimOj2atB4UjHYJ83fCEPkLg55LHoeoZfY@z>

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
