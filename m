Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:56175 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAIUHe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 15:07:34 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so13574749ith.5
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 12:07:34 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-6-axboe@kernel.dk> <20190109121030.GA13779@lst.de>
 <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
 <20190109183059.GA21824@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <762caadb-1deb-19c4-705b-c11abd8c1abf@kernel.dk>
Date: Wed, 9 Jan 2019 13:07:31 -0700
MIME-Version: 1.0
In-Reply-To: <20190109183059.GA21824@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109200731.YsYZsiIKgZPvPqVl0CGzWlpQmJc5zQTi2-G3z92KWp8@z>

On 1/9/19 11:30 AM, Christoph Hellwig wrote:
> On Wed, Jan 09, 2019 at 08:53:31AM -0700, Jens Axboe wrote:
>>>> +static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
>>>> +		       struct iovec **iovec, struct iov_iter *iter)
>>>> +{
>>>> +	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
>>>> +	size_t ret;
>>>> +
>>>> +	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>>>> +	*iovec = NULL;
>>>> +	return ret;
>>>> +}
>>>
>>> Is there any point in supporting non-vectored operations here?
>>
>> Not sure I follow?
> 
> This version only supports non-vectored read and write, that is
> the equivalent of pread/pwrite.  Many AIO users really need vectored
> operations, that is preadv/pwritev semantics indirecting through
> a struct iovec array.  The non-vectored version can be trivially
> emulated using a vector of 1, which is what we do in the kernel
> I/O stack everywhere.  So I think we should just support the vectored
> version here, and not the non-vectored one.  See my io_uring branch
> for the sketeched implementation.

OK, I see what you mean, so only supported the vectored version.
Probably makes more sense, I'll make the change.

-- 
Jens Axboe
