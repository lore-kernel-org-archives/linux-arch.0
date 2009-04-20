From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] kmap_types: make most arches use generic header file
Date: Mon, 20 Apr 2009 10:38:21 -0400
Message-ID: <8bd0f97a0904200738m355642ebqaf682cf9c66d3b4b@mail.gmail.com>
References: <20090417183210.6b704b24.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:42109 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbZDTOiW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Apr 2009 10:38:22 -0400
In-Reply-To: <20090417183210.6b704b24.randy.dunlap@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, Apr 17, 2009 at 21:32, Randy Dunlap wrote:
> --- linux-2.6.30-rc2-git1.orig/arch/blackfin/include/asm/kmap_types.h
> +++ linux-2.6.30-rc2-git1/arch/blackfin/include/asm/kmap_types.h
> @@ -1,21 +1,6 @@
> =C2=A0#ifndef _ASM_KMAP_TYPES_H
> =C2=A0#define _ASM_KMAP_TYPES_H
>
> -enum km_type {
> - =C2=A0 =C2=A0 =C2=A0 KM_BOUNCE_READ,
> - =C2=A0 =C2=A0 =C2=A0 KM_SKB_SUNRPC_DATA,
> - =C2=A0 =C2=A0 =C2=A0 KM_SKB_DATA_SOFTIRQ,
> - =C2=A0 =C2=A0 =C2=A0 KM_USER0,
> - =C2=A0 =C2=A0 =C2=A0 KM_USER1,
> - =C2=A0 =C2=A0 =C2=A0 KM_BIO_SRC_IRQ,
> - =C2=A0 =C2=A0 =C2=A0 KM_BIO_DST_IRQ,
> - =C2=A0 =C2=A0 =C2=A0 KM_PTE0,
> - =C2=A0 =C2=A0 =C2=A0 KM_PTE1,
> - =C2=A0 =C2=A0 =C2=A0 KM_IRQ0,
> - =C2=A0 =C2=A0 =C2=A0 KM_IRQ1,
> - =C2=A0 =C2=A0 =C2=A0 KM_SOFTIRQ0,
> - =C2=A0 =C2=A0 =C2=A0 KM_SOFTIRQ1,
> - =C2=A0 =C2=A0 =C2=A0 KM_TYPE_NR
> -};
> +#include <asm-generic/kmap_types.h>
>
> =C2=A0#endif

if the header is only there to redirect to the generic one, seems like
we could drop the #ifdef protection

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
