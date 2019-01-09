From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Date: Wed, 9 Jan 2019 13:07:31 -0700
Message-ID: <762caadb-1deb-19c4-705b-c11abd8c1abf@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-6-axboe@kernel.dk> <20190109121030.GA13779@lst.de>
 <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
 <20190109183059.GA21824@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190109183059.GA21824@lst.de>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
