From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 05/15] Add io_uring IO interface
Date: Fri, 11 Jan 2019 13:19:35 -0500
Message-ID: <yq1sgxzys3s.fsf@oracle.com>
References: <20190110024404.25372-1-axboe@kernel.dk>
	<20190110024404.25372-6-axboe@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110024404.25372-6-axboe@kernel.dk> (Jens Axboe's message of
	"Wed, 9 Jan 2019 19:43:54 -0700")
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org


Jens,

> +struct io_uring_sqe {
> +	__u8	opcode;
> +	__u8	flags;
> +	__u16	ioprio;
> +	__s32	fd;
> +	__u64	off;
> +	union {
> +		void	*addr;
> +		__u64	__pad;
> +	};
> +	__u32	len;
> +	union {
> +		__kernel_rwf_t	rw_flags;
> +		__u32		__resv;
> +	};
> +};

A bit tongue in cheek and yet somewhat serious: While I'm super excited
about the 4 x 64 bitness of the sqe, where does the integrity buffer go?
Or the 128-bit KV store key. How do we extend this interface beyond the
flags?

-- 
Martin K. Petersen	Oracle Linux Engineering

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
