Return-Path: <SRS0=F7pE=5Y=kvack.org=owner-linux-mm@kernel.org>
From: Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 02/28] staging: android: ion: use vmap instead of vm_map_ram
Date: Wed,  8 Apr 2020 20:48:33 +0800
Message-ID: <20200408124833.13032-1-hdanton@sina.com>
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200408124833.utfI5zq5FxrPp38YI331BD5J79SC6Ps8HbZnKx8sNqQ@z>


On Wed,  8 Apr 2020 13:59:00 +0200
>=20
> vm_map_ram can keep mappings around after the vm_unmap_ram.  Using that
> with non-PAGE_KERNEL mappings can lead to all kinds of aliasing issues.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/staging/android/ion/ion_heap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/a=
ndroid/ion/ion_heap.c
> index 473b465724f1..a2d5c6df4b96 100644
> --- a/drivers/staging/android/ion/ion_heap.c
> +++ b/drivers/staging/android/ion/ion_heap.c
> @@ -99,12 +99,12 @@ int ion_heap_map_user(struct ion_heap *heap, struct=
 ion_buffer *buffer,
> =20
>  static int ion_heap_clear_pages(struct page **pages, int num, pgprot_t=
 pgprot)
>  {
> -	void *addr =3D vm_map_ram(pages, num, -1, pgprot);
> +	void *addr =3D vmap(pages, num, VM_MAP);

A merge glitch?

void *vmap(struct page **pages, unsigned int count,
	   unsigned long flags, pgprot_t prot)
> =20
>  	if (!addr)
>  		return -ENOMEM;
>  	memset(addr, 0, PAGE_SIZE * num);
> -	vm_unmap_ram(addr, num);
> +	vunmap(addr);
> =20
>  	return 0;
>  }
> --=20
> 2.25.1
