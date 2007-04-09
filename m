Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:22162 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966145AbXDIQZK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Apr 2007 12:25:10 -0400
Received: by py-out-1112.google.com with SMTP id a29so1070180pyi
        for <linux-arch@vger.kernel.org>; Mon, 09 Apr 2007 09:25:09 -0700 (PDT)
Message-ID: <961aa3350704090925q6e8659c9od3803d6cac35b455@mail.gmail.com>
Date: Tue, 10 Apr 2007 01:25:09 +0900
From: "Akinobu Mita" <akinobu.mita@gmail.com>
Subject: Re: [PATCH] slob: handle SLAB_PANIC flag
In-Reply-To: <20070409145758.GO4892@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070409130847.GA5048@APFDCB5C> <20070409145758.GO4892@waste.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

2007/4/9, Matt Mackall <mpm@selenic.com>:

> > Index: 2.6-mm/mm/slob.c
> > ===================================================================
> > --- 2.6-mm.orig/mm/slob.c
> > +++ 2.6-mm/mm/slob.c
> > @@ -298,6 +298,9 @@ struct kmem_cache *kmem_cache_create(con
> >               c->align = (flags & SLAB_MUST_HWCACHE_ALIGN) ? SLOB_ALIGN : 0;
> >               if (c->align < align)
> >                       c->align = align;
> > +     } else {
> > +             if (flags & SLAB_PANIC)
> > +                     panic("Cannot create slab cache %s\n", name);
> >       }
>
> I think this would be more canonical:
>
> } else if (..)
>    panic();

Thanks, the patch updated.

From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] slob: handle SLAB_PANIC flag

kmem_cache_create() for slob doesn't handle SLAB_PANIC.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 mm/slob.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6-mm/mm/slob.c
===================================================================
--- 2.6-mm.orig/mm/slob.c
+++ 2.6-mm/mm/slob.c
@@ -298,7 +298,8 @@ struct kmem_cache *kmem_cache_create(con
 		c->align = (flags & SLAB_MUST_HWCACHE_ALIGN) ? SLOB_ALIGN : 0;
 		if (c->align < align)
 			c->align = align;
-	}
+	} else if (flags & SLAB_PANIC)
+		panic("Cannot create slab cache %s\n", name);

 	return c;
 }
