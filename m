From: Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH 05/15] Add io_uring IO interface
Date: Thu, 17 Jan 2019 13:48:16 +0100
Message-ID: <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190116175003.17880-6-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2019-01-16 18:49, Jens Axboe wrote:

[...]

> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
> +				  struct io_uring_params *p)
> +{
> +	struct io_sq_ring *sq_ring;
> +	struct io_cq_ring *cq_ring;
> +	size_t size;
> +	int ret;
> +
> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));

It seems that sq_entries, cq_entries are not limited at all.  Can nasty
app consume a lot of kernel pages calling io_setup_uring() from a loop
passing random entries number? (or even better: decreasing entries 
number,
in order to consume all pages orders with min number of loops).

--
Roman

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
