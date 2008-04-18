From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel stack allocation alignment
Date: Fri, 18 Apr 2008 00:06:18 -0700
Message-ID: <20080418000618.0c46c78f.akpm@linux-foundation.org>
References: <20080418065727.5FE1CDE247@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080418065727.5FE1CDE247-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 18 Apr 2008 16:56:17 +1000 Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> wrote:

> The powerpc kernel stacks need to be naturally aligned, as they
> contain the thread info at the bottom, which is obtained by
> clearing the low bits of the stack pointer.
> 
> However, when using 64K pages (the stack is smaller than a page),
> we use kmalloc to allocate it, which doesn't provide that guarantee.
> 
> It appeared to work so far... until one enables SLUB debugging
> which then returns unaligned pointers. Ooops...
> 
> This patch fixes it by using a slab cache with enforced alignment
> for those. It replies on my previous patch that adds a
> thread_info_cache_init() callback.
> 
> ...
>
> +void thread_info_cache_init(void)
> +{
> +	thread_info_cache = kmem_cache_create("thread_info", THREAD_SIZE,
> +					      THREAD_SIZE, 0, NULL);
> +	BUG_ON(thread_info_cache == NULL);
> +}

so...  the "0" defeats all of SLAB_DEBUG_FREE, SLAB_RED_ZONE, SLAB_POISON
and SLAB_STORE_USER, if the comment in slab.h is to be believed.

Was that overkill?
