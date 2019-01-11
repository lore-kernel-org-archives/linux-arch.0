Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34647 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfAKSep (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jan 2019 13:34:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so6665131pga.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Jan 2019 10:34:44 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
References: <20190110024404.25372-1-axboe@kernel.dk>
 <20190110024404.25372-6-axboe@kernel.dk> <yq1sgxzys3s.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
Date: Fri, 11 Jan 2019 11:34:40 -0700
MIME-Version: 1.0
In-Reply-To: <yq1sgxzys3s.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190111183440.Ltrq-0pHCCiY6iqitRndPUL2avqDneByqVLZbj24xmU@z>

On 1/11/19 11:19 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> +struct io_uring_sqe {
>> +	__u8	opcode;
>> +	__u8	flags;
>> +	__u16	ioprio;
>> +	__s32	fd;
>> +	__u64	off;
>> +	union {
>> +		void	*addr;
>> +		__u64	__pad;
>> +	};
>> +	__u32	len;
>> +	union {
>> +		__kernel_rwf_t	rw_flags;
>> +		__u32		__resv;
>> +	};
>> +};
> 
> A bit tongue in cheek and yet somewhat serious: While I'm super excited
> about the 4 x 64 bitness of the sqe, where does the integrity buffer go?
> Or the 128-bit KV store key. How do we extend this interface beyond the
> flags?

For integrity buffers, how about we stash them on the side? The newer
series has an extra system call, io_uring_register(), which is currently
used for registering files and buffers for IO on the side. You could
trivially tie an integrity buffer to an sqe through that.

For KV, I thint that's an actually interesting use case (sorry,
integrity), and we might just want to bite the bullet and extend the sqe
to full 64 bytes.  We're currently at 48 bytes, which leaves us with 16
bytes of space for KV, and other use cases.

-- 
Jens Axboe
