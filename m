Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57518 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab3F0I3a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 04:29:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: m32r: include: asm: add "dma-mapping-common.h"
Date: Thu, 27 Jun 2013 10:30:51 +0200
Message-ID: <2831217.RWPZkclVnp@wuerfel>
In-Reply-To: <51CBC4B3.807@asianux.com>
References: <51CBC4B3.807@asianux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>, "dhowells@redhat.com" <dhowells@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Rusty Russell <rusty@rustcorp.com.au>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20130627083051.3SSdVzhOFfuxbrfh1fkDzW3Rgrsrfwws86HVK8K20ag@z>

On Thursday 27 June 2013 12:50:59 Chen Gang wrote:
> Need add generic "dma-mapping-common.h", or compiling may fail.
> 
> The related error (with allmodconfig):
> 
>     CC [M]  net/irda/irlan/irlan_eth.o
>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function ‘vb2_dc_mmap’:
>   drivers/media/v4l2-core/videobuf2-dma-contig.c:202:2: error: implicit declaration of function ‘dma_mmap_coherent’ [-Werror=implicit-function-declaration]
>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function ‘vb2_dc_get_base_sgt’:
>   drivers/media/v4l2-core/videobuf2-dma-contig.c:385:2: error: implicit declaration of function ‘dma_get_sgtable’ [-Werror=implicit-function-declaration]
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

m32r does not provide the "common" version of the dma mapping API, so this
is certainly wrong.

	Arnd
