Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268154AbUHTXXc@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:4332 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268113AbUHTXXc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 19:23:32 -0400
Date: Sat, 21 Aug 2004 09:18:33 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: copy_mount_options()
Message-ID: <20040820231833.GH1945@krispykreme>
References: <20040820130110.07f7c23c.davem@redhat.com> <20040820131053.3d5e0f9b.akpm@osdl.org> <20040820141137.646c349f.davem@redhat.com> <20040820143111.3fd0070e.akpm@osdl.org> <20040820144052.14413a4f.davem@redhat.com> <20040820154736.166b66ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820154736.166b66ec.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>


> OK, here's #2, with enhanced comment and changelog!
> 
> Untested though.

That removes one more place that uses the return value of 
copy_to/from_user.

Queue Rusty's "copy_from_user is a deathtrap" spiel:

http://www.ussg.iu.edu/hypermail/linux/kernel/0205.2/0193.html

I too hate that interface, Im continually getting it wrong. It would be
nice to remove the possibility of having similar such subtle bugs.

Anton

> davem says that copy_mount_options is failing in obscure ways if the
> architecture's copy_from_user() doesn't return an exact count of the number of
> uncopied bytes.
> 
> Fixing that up in each architecture is a pain - it involves falling back to
> byte-at-a-time copies.
> 
> It's simple to open-code this in namespace.c.  If we find other places in the
> kernel which care about this we can promote this to a global function.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  25-akpm/fs/namespace.c |   30 ++++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff -puN fs/namespace.c~copy_mount_options-size-fix fs/namespace.c
> --- 25/fs/namespace.c~copy_mount_options-size-fix	Fri Aug 20 15:43:26 2004
> +++ 25-akpm/fs/namespace.c	Fri Aug 20 15:46:05 2004
> @@ -930,7 +930,33 @@ void mark_mounts_for_expiry(struct list_
>  
>  EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
>  
> -int copy_mount_options (const void __user *data, unsigned long *where)
> +/*
> + * Some copy_from_user() implementations do not return the exact number of
> + * bytes remaining to copy on a fault.  But copy_mount_options() requires that.
> + * Note that this function differs from copy_from_user() in that it will oops
> + * on bad values of `to', rather than returning a short copy.
> + */
> +static long
> +exact_copy_from_user(void *to, const void __user *from, unsigned long n)
> +{
> +	char *t = to;
> +	const char __user *f = from;
> +	char c;
> +
> +	if (!access_ok(VERIFY_READ, from, n))
> +		return n;
> +
> +	while (n) {
> +		if (__get_user(c, f))
> +			break;
> +		*t++ = c;
> +		f++;
> +		n--;
> +	}
> +	return n;
> +}
> +
> +int copy_mount_options(const void __user *data, unsigned long *where)
>  {
>  	int i;
>  	unsigned long page;
> @@ -952,7 +978,7 @@ int copy_mount_options (const void __use
>  	if (size > PAGE_SIZE)
>  		size = PAGE_SIZE;
>  
> -	i = size - copy_from_user((void *)page, data, size);
> +	i = size - exact_copy_from_user((void *)page, data, size);
>  	if (!i) {
>  		free_page(page); 
>  		return -EFAULT;
> _
