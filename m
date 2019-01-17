From: Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH 05/15] Add io_uring IO interface
Date: Thu, 17 Jan 2019 13:02:21 +0100
Message-ID: <362738449bd3f83d18cb1056acc9b875@suse.de>
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

Hi Jens,

On 2019-01-16 18:49, Jens Axboe wrote:

[...]

> +static void *io_mem_alloc(size_t size)
> +{
> +	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP 
> |
> +				__GFP_NORETRY;
> +
> +	return (void *) __get_free_pages(gfp_flags, get_order(size));

Since these pages are shared between kernel and userspace, do we need
to care about d-cache aliasing on armv6 (or other "strange" archs
which I've never seen) with vivt or vipt cpu caches?

E.g. vmalloc_user() targets this problem by aligning kernel address
on SHMLBA, so no flush_dcache_page() is required.

--
Roman

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
