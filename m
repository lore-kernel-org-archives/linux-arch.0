Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40887 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfAMQWV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jan 2019 11:22:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so9210917pfo.7
        for <linux-arch@vger.kernel.org>; Sun, 13 Jan 2019 08:22:20 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
From: Jens Axboe <axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
 <20190110024404.25372-6-axboe@kernel.dk> <yq1sgxzys3s.fsf@oracle.com>
 <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
Message-ID: <54976aac-bef2-880f-dc10-e3030189a08a@kernel.dk>
Date: Sun, 13 Jan 2019 09:22:16 -0700
MIME-Version: 1.0
In-Reply-To: <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190113162216.yXufHPs2sv7OLY3vR7akNOOSlctULEYBnGKRZOKJatc@z>

On 1/11/19 11:34 AM, Jens Axboe wrote:
> On 1/11/19 11:19 AM, Martin K. Petersen wrote:
>>
>> Jens,
>>
>>> +struct io_uring_sqe {
>>> +	__u8	opcode;
>>> +	__u8	flags;
>>> +	__u16	ioprio;
>>> +	__s32	fd;
>>> +	__u64	off;
>>> +	union {
>>> +		void	*addr;
>>> +		__u64	__pad;
>>> +	};
>>> +	__u32	len;
>>> +	union {
>>> +		__kernel_rwf_t	rw_flags;
>>> +		__u32		__resv;
>>> +	};
>>> +};
>>
>> A bit tongue in cheek and yet somewhat serious: While I'm super excited
>> about the 4 x 64 bitness of the sqe, where does the integrity buffer go?
>> Or the 128-bit KV store key. How do we extend this interface beyond the
>> flags?
> 
> For integrity buffers, how about we stash them on the side? The newer
> series has an extra system call, io_uring_register(), which is currently
> used for registering files and buffers for IO on the side. You could
> trivially tie an integrity buffer to an sqe through that.
> 
> For KV, I thint that's an actually interesting use case (sorry,
> integrity), and we might just want to bite the bullet and extend the sqe
> to full 64 bytes.  We're currently at 48 bytes, which leaves us with 16
> bytes of space for KV, and other use cases.

I bit the bullet and bumped the size. 64 bytes is a nicer size in terms
of cachelines anyway, and I really doubt that 48 vs 64 bytes makes a
size consumption problem for anyone.

The buf_index is only used for the fixed buffers, which means that we have
16 bytes / 128 bits that we can grab for things like KV.

-- 
Jens Axboe
