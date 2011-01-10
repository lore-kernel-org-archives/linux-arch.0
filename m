From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Mon, 10 Jan 2011 11:50:19 +0100
Message-ID: <20110110105019.GC24920@pengutronix.de>
References: <1294268808.2952.18.camel@heimdal.trondhjem.org>
 <1294270104.16957.73.camel@mulgrave.site>
 <1294335614.22825.154.camel@mulgrave.site>
 <1294336054.2905.1.camel@heimdal.trondhjem.org>
 <AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com>
 <1294426405.2929.23.camel@heimdal.trondhjem.org>
 <20110107190229.GX31708@n2100.arm.linux.org.uk>
 <1294427467.4895.66.camel@mulgrave.site>
 <1294505384.4181.14.camel@heimdal.trondhjem.org>
 <1294528551.4181.19.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294528551.4181.19.camel-rJ7iovZKK19ZJLDQqaL3InhyD016LWXt@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Cc: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marc Kleine-Budde <m.kleine-budde-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Trond,

On Sat, Jan 08, 2011 at 06:15:51PM -0500, Trond Myklebust wrote:
> ---------------------------------------------------------------------=
--------------=20
It would be great if you could add a "8<" in the line above next time.
Then git-am -c does the right thing (at least I think so).

> From 8b2e60cef5c65eef41ab61286f62dec6bfb1ac27 Mon Sep 17 00:00:00 200=
1
> From: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
> Date: Sat, 8 Jan 2011 17:45:38 -0500
> Subject: [PATCH] NFS: Don't use vm_map_ram() in readdir
>=20
> vm_map_ram() is not available on NOMMU platforms, and causes trouble
> on incoherrent architectures such as ARM when we access the page data
> through both the direct and the virtual mapping.
>=20
> The alternative is to use the direct mapping to access page data
> for the case when we are not crossing a page boundary, but to copy
> the data into a linear scratch buffer when we are accessing data
> that spans page boundaries.
>=20
> Signed-off-by: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

on tx28.

Thanks
Uwe

> ---
>  fs/nfs/dir.c               |   44 ++++++-------
>  fs/nfs/nfs2xdr.c           |    6 --
>  fs/nfs/nfs3xdr.c           |    6 --
>  fs/nfs/nfs4xdr.c           |    6 --
>  include/linux/sunrpc/xdr.h |    4 +-
>  net/sunrpc/xdr.c           |  155 ++++++++++++++++++++++++++++++++++=
+---------
>  6 files changed, 148 insertions(+), 73 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 996dd89..0108cf4 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -33,7 +33,6 @@
>  #include <linux/namei.h>
>  #include <linux/mount.h>
>  #include <linux/sched.h>
> -#include <linux/vmalloc.h>
>  #include <linux/kmemleak.h>
> =20
>  #include "delegation.h"
> @@ -459,25 +458,26 @@ out:
>  /* Perform conversion from xdr to cache array */
>  static
>  int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct n=
fs_entry *entry,
> -				void *xdr_page, struct page *page, unsigned int buflen)
> +				struct page **xdr_pages, struct page *page, unsigned int buflen)
>  {
>  	struct xdr_stream stream;
> -	struct xdr_buf buf;
> -	__be32 *ptr =3D xdr_page;
> +	struct xdr_buf buf =3D {
> +		.pages =3D xdr_pages,
> +		.page_len =3D buflen,
> +		.buflen =3D buflen,
> +		.len =3D buflen,
> +	};
> +	struct page *scratch;
>  	struct nfs_cache_array *array;
>  	unsigned int count =3D 0;
>  	int status;
> =20
> -	buf.head->iov_base =3D xdr_page;
> -	buf.head->iov_len =3D buflen;
> -	buf.tail->iov_len =3D 0;
> -	buf.page_base =3D 0;
> -	buf.page_len =3D 0;
> -	buf.buflen =3D buf.head->iov_len;
> -	buf.len =3D buf.head->iov_len;
> -
> -	xdr_init_decode(&stream, &buf, ptr);
> +	scratch =3D alloc_page(GFP_KERNEL);
> +	if (scratch =3D=3D NULL)
> +		return -ENOMEM;
> =20
> +	xdr_init_decode(&stream, &buf, NULL);
> +	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
> =20
>  	do {
>  		status =3D xdr_decode(desc, entry, &stream);
> @@ -506,6 +506,8 @@ int nfs_readdir_page_filler(nfs_readdir_descripto=
r_t *desc, struct nfs_entry *en
>  		} else
>  			status =3D PTR_ERR(array);
>  	}
> +
> +	put_page(scratch);
>  	return status;
>  }
> =20
> @@ -521,7 +523,6 @@ static
>  void nfs_readdir_free_large_page(void *ptr, struct page **pages,
>  		unsigned int npages)
>  {
> -	vm_unmap_ram(ptr, npages);
>  	nfs_readdir_free_pagearray(pages, npages);
>  }
> =20
> @@ -530,9 +531,8 @@ void nfs_readdir_free_large_page(void *ptr, struc=
t page **pages,
>   * to nfs_readdir_free_large_page
>   */
>  static
> -void *nfs_readdir_large_page(struct page **pages, unsigned int npage=
s)
> +int nfs_readdir_large_page(struct page **pages, unsigned int npages)
>  {
> -	void *ptr;
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < npages; i++) {
> @@ -541,13 +541,11 @@ void *nfs_readdir_large_page(struct page **page=
s, unsigned int npages)
>  			goto out_freepages;
>  		pages[i] =3D page;
>  	}
> +	return 0;
> =20
> -	ptr =3D vm_map_ram(pages, npages, 0, PAGE_KERNEL);
> -	if (!IS_ERR_OR_NULL(ptr))
> -		return ptr;
>  out_freepages:
>  	nfs_readdir_free_pagearray(pages, i);
> -	return NULL;
> +	return -ENOMEM;
>  }
> =20
>  static
> @@ -577,8 +575,8 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descript=
or_t *desc, struct page *page,
>  	memset(array, 0, sizeof(struct nfs_cache_array));
>  	array->eof_index =3D -1;
> =20
> -	pages_ptr =3D nfs_readdir_large_page(pages, array_size);
> -	if (!pages_ptr)
> +	status =3D nfs_readdir_large_page(pages, array_size);
> +	if (status < 0)
>  		goto out_release_array;
>  	do {
>  		unsigned int pglen;
> @@ -587,7 +585,7 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descript=
or_t *desc, struct page *page,
>  		if (status < 0)
>  			break;
>  		pglen =3D status;
> -		status =3D nfs_readdir_page_filler(desc, &entry, pages_ptr, page, =
pglen);
> +		status =3D nfs_readdir_page_filler(desc, &entry, pages, page, pgle=
n);
>  		if (status < 0) {
>  			if (status =3D=3D -ENOSPC)
>  				status =3D 0;
> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> index 5914a19..b382a1b 100644
> --- a/fs/nfs/nfs2xdr.c
> +++ b/fs/nfs/nfs2xdr.c
> @@ -487,12 +487,6 @@ nfs_decode_dirent(struct xdr_stream *xdr, struct=
 nfs_entry *entry, struct nfs_se
> =20
>  	entry->d_type =3D DT_UNKNOWN;
> =20
> -	p =3D xdr_inline_peek(xdr, 8);
> -	if (p !=3D NULL)
> -		entry->eof =3D !p[0] && p[1];
> -	else
> -		entry->eof =3D 0;
> -
>  	return p;
> =20
>  out_overflow:
> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> index f6cc60f..ba91236 100644
> --- a/fs/nfs/nfs3xdr.c
> +++ b/fs/nfs/nfs3xdr.c
> @@ -647,12 +647,6 @@ nfs3_decode_dirent(struct xdr_stream *xdr, struc=
t nfs_entry *entry, struct nfs_s
>  			memset((u8*)(entry->fh), 0, sizeof(*entry->fh));
>  	}
> =20
> -	p =3D xdr_inline_peek(xdr, 8);
> -	if (p !=3D NULL)
> -		entry->eof =3D !p[0] && p[1];
> -	else
> -		entry->eof =3D 0;
> -
>  	return p;
> =20
>  out_overflow:
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 9f1826b..0662a98 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -6215,12 +6215,6 @@ __be32 *nfs4_decode_dirent(struct xdr_stream *=
xdr, struct nfs_entry *entry,
>  	if (verify_attr_len(xdr, p, len) < 0)
>  		goto out_overflow;
> =20
> -	p =3D xdr_inline_peek(xdr, 8);
> -	if (p !=3D NULL)
> -		entry->eof =3D !p[0] && p[1];
> -	else
> -		entry->eof =3D 0;
> -
>  	return p;
> =20
>  out_overflow:
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 498ab93..7783c68 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -201,6 +201,8 @@ struct xdr_stream {
> =20
>  	__be32 *end;		/* end of available buffer space */
>  	struct kvec *iov;	/* pointer to the current kvec */
> +	struct kvec scratch;	/* Scratch buffer */
> +	struct page **page_ptr;	/* pointer to the current page */
>  };
> =20
>  extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *=
buf, __be32 *p);
> @@ -208,7 +210,7 @@ extern __be32 *xdr_reserve_space(struct xdr_strea=
m *xdr, size_t nbytes);
>  extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pa=
ges,
>  		unsigned int base, unsigned int len);
>  extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *=
buf, __be32 *p);
> -extern __be32 *xdr_inline_peek(struct xdr_stream *xdr, size_t nbytes=
);
> +extern void xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf=
, size_t buflen);
>  extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbyt=
es);
>  extern void xdr_read_pages(struct xdr_stream *xdr, unsigned int len)=
;
>  extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len)=
;
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index cd9e841..679cd67 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -552,6 +552,74 @@ void xdr_write_pages(struct xdr_stream *xdr, str=
uct page **pages, unsigned int b
>  }
>  EXPORT_SYMBOL_GPL(xdr_write_pages);
> =20
> +static void xdr_set_iov(struct xdr_stream *xdr, struct kvec *iov,
> +		__be32 *p, unsigned int len)
> +{
> +	if (len > iov->iov_len)
> +		len =3D iov->iov_len;
> +	if (p =3D=3D NULL)
> +		p =3D (__be32*)iov->iov_base;
> +	xdr->p =3D p;
> +	xdr->end =3D (__be32*)(iov->iov_base + len);
> +	xdr->iov =3D iov;
> +	xdr->page_ptr =3D NULL;
> +}
> +
> +static int xdr_set_page_base(struct xdr_stream *xdr,
> +		unsigned int base, unsigned int len)
> +{
> +	unsigned int pgnr;
> +	unsigned int maxlen;
> +	unsigned int pgoff;
> +	unsigned int pgend;
> +	void *kaddr;
> +
> +	maxlen =3D xdr->buf->page_len;
> +	if (base >=3D maxlen)
> +		return -EINVAL;
> +	maxlen -=3D base;
> +	if (len > maxlen)
> +		len =3D maxlen;
> +
> +	base +=3D xdr->buf->page_base;
> +
> +	pgnr =3D base >> PAGE_SHIFT;
> +	xdr->page_ptr =3D &xdr->buf->pages[pgnr];
> +	kaddr =3D page_address(*xdr->page_ptr);
> +
> +	pgoff =3D base & ~PAGE_MASK;
> +	xdr->p =3D (__be32*)(kaddr + pgoff);
> +
> +	pgend =3D pgoff + len;
> +	if (pgend > PAGE_SIZE)
> +		pgend =3D PAGE_SIZE;
> +	xdr->end =3D (__be32*)(kaddr + pgend);
> +	xdr->iov =3D NULL;
> +	return 0;
> +}
> +
> +static void xdr_set_next_page(struct xdr_stream *xdr)
> +{
> +	unsigned int newbase;
> +
> +	newbase =3D (1 + xdr->page_ptr - xdr->buf->pages) << PAGE_SHIFT;
> +	newbase -=3D xdr->buf->page_base;
> +
> +	if (xdr_set_page_base(xdr, newbase, PAGE_SIZE) < 0)
> +		xdr_set_iov(xdr, xdr->buf->tail, NULL, xdr->buf->len);
> +}
> +
> +static bool xdr_set_next_buffer(struct xdr_stream *xdr)
> +{
> +	if (xdr->page_ptr !=3D NULL)
> +		xdr_set_next_page(xdr);
> +	else if (xdr->iov =3D=3D xdr->buf->head) {
> +		if (xdr_set_page_base(xdr, 0, PAGE_SIZE) < 0)
> +			xdr_set_iov(xdr, xdr->buf->tail, NULL, xdr->buf->len);
> +	}
> +	return xdr->p !=3D xdr->end;
> +}
> +
>  /**
>   * xdr_init_decode - Initialize an xdr_stream for decoding data.
>   * @xdr: pointer to xdr_stream struct
> @@ -560,41 +628,67 @@ EXPORT_SYMBOL_GPL(xdr_write_pages);
>   */
>  void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __=
be32 *p)
>  {
> -	struct kvec *iov =3D buf->head;
> -	unsigned int len =3D iov->iov_len;
> -
> -	if (len > buf->len)
> -		len =3D buf->len;
>  	xdr->buf =3D buf;
> -	xdr->iov =3D iov;
> -	xdr->p =3D p;
> -	xdr->end =3D (__be32 *)((char *)iov->iov_base + len);
> +	xdr->scratch.iov_base =3D NULL;
> +	xdr->scratch.iov_len =3D 0;
> +	if (buf->head[0].iov_len !=3D 0)
> +		xdr_set_iov(xdr, buf->head, p, buf->len);
> +	else if (buf->page_len !=3D 0)
> +		xdr_set_page_base(xdr, 0, buf->len);
>  }
>  EXPORT_SYMBOL_GPL(xdr_init_decode);
> =20
> -/**
> - * xdr_inline_peek - Allow read-ahead in the XDR data stream
> - * @xdr: pointer to xdr_stream struct
> - * @nbytes: number of bytes of data to decode
> - *
> - * Check if the input buffer is long enough to enable us to decode
> - * 'nbytes' more bytes of data starting at the current position.
> - * If so return the current pointer without updating the current
> - * pointer position.
> - */
> -__be32 * xdr_inline_peek(struct xdr_stream *xdr, size_t nbytes)
> +static __be32 * __xdr_inline_decode(struct xdr_stream *xdr, size_t n=
bytes)
>  {
>  	__be32 *p =3D xdr->p;
>  	__be32 *q =3D p + XDR_QUADLEN(nbytes);
> =20
>  	if (unlikely(q > xdr->end || q < p))
>  		return NULL;
> +	xdr->p =3D q;
>  	return p;
>  }
> -EXPORT_SYMBOL_GPL(xdr_inline_peek);
> =20
>  /**
> - * xdr_inline_decode - Retrieve non-page XDR data to decode
> + * xdr_set_scratch_buffer - Attach a scratch buffer for decoding dat=
a.
> + * @xdr: pointer to xdr_stream struct
> + * @buf: pointer to an empty buffer
> + * @buflen: size of 'buf'
> + *
> + * The scratch buffer is used when decoding from an array of pages.
> + * If an xdr_inline_decode() call spans across page boundaries, then
> + * we copy the data into the scratch buffer in order to allow linear
> + * access.
> + */
> +void xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_=
t buflen)
> +{
> +	xdr->scratch.iov_base =3D buf;
> +	xdr->scratch.iov_len =3D buflen;
> +}
> +EXPORT_SYMBOL_GPL(xdr_set_scratch_buffer);
> +
> +static __be32 *xdr_copy_to_scratch(struct xdr_stream *xdr, size_t nb=
ytes)
> +{
> +	__be32 *p;
> +	void *cpdest =3D xdr->scratch.iov_base;
> +	size_t cplen =3D (char *)xdr->end - (char *)xdr->p;
> +
> +	if (nbytes > xdr->scratch.iov_len)
> +		return NULL;
> +	memcpy(cpdest, xdr->p, cplen);
> +	cpdest +=3D cplen;
> +	nbytes -=3D cplen;
> +	if (!xdr_set_next_buffer(xdr))
> +		return NULL;
> +	p =3D __xdr_inline_decode(xdr, nbytes);
> +	if (p =3D=3D NULL)
> +		return NULL;
> +	memcpy(cpdest, p, nbytes);
> +	return xdr->scratch.iov_base;
> +}
> +
> +/**
> + * xdr_inline_decode - Retrieve XDR data to decode
>   * @xdr: pointer to xdr_stream struct
>   * @nbytes: number of bytes of data to decode
>   *
> @@ -605,13 +699,16 @@ EXPORT_SYMBOL_GPL(xdr_inline_peek);
>   */
>  __be32 * xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes)
>  {
> -	__be32 *p =3D xdr->p;
> -	__be32 *q =3D p + XDR_QUADLEN(nbytes);
> +	__be32 *p;
> =20
> -	if (unlikely(q > xdr->end || q < p))
> +	if (nbytes =3D=3D 0)
> +		return xdr->p;
> +	if (xdr->p =3D=3D xdr->end && !xdr_set_next_buffer(xdr))
>  		return NULL;
> -	xdr->p =3D q;
> -	return p;
> +	p =3D __xdr_inline_decode(xdr, nbytes);
> +	if (p !=3D NULL)
> +		return p;
> +	return xdr_copy_to_scratch(xdr, nbytes);
>  }
>  EXPORT_SYMBOL_GPL(xdr_inline_decode);
> =20
> @@ -671,16 +768,12 @@ EXPORT_SYMBOL_GPL(xdr_read_pages);
>   */
>  void xdr_enter_page(struct xdr_stream *xdr, unsigned int len)
>  {
> -	char * kaddr =3D page_address(xdr->buf->pages[0]);
>  	xdr_read_pages(xdr, len);
>  	/*
>  	 * Position current pointer at beginning of tail, and
>  	 * set remaining message length.
>  	 */
> -	if (len > PAGE_CACHE_SIZE - xdr->buf->page_base)
> -		len =3D PAGE_CACHE_SIZE - xdr->buf->page_base;
> -	xdr->p =3D (__be32 *)(kaddr + xdr->buf->page_base);
> -	xdr->end =3D (__be32 *)((char *)xdr->p + len);
> +	xdr_set_page_base(xdr, 0, len);
>  }
>  EXPORT_SYMBOL_GPL(xdr_enter_page);
> =20
> --=20
> 1.7.3.4
>=20
>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer
>=20
> NetApp
> Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org
> www.netapp.com
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
