From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/9] Provide dma_mmap_coherent() and dma_get_sgtable()
Date: Sun, 27 Jan 2013 11:33:19 +0100
Message-ID: <1359282808-31398-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:59661 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411Ab3A0Kdd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Jan 2013 05:33:33 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

dma_common_mmap() and dma_common_get_sgtable() are defined in
drivers/base/dma-mapping.c, and always compiled if CONFIG_HAS_DMA=3Dy.

However, their forward declarations and the inline functions defined on=
 top
of them (dma_mmap_attrs(), dma_mmap_coherent(), dma_mmap_writecombine()=
,
dma_get_sgtable_attrs()), dma_get_sgtable()) are in
<asm-generic/dma-mapping-common.h>, which is not included by all
architectures supporting CONFIG_HAS_DMA=3Dy.  There exist no alternativ=
e
implementations.

Hence for e.g. m68k allmodconfig, I get:

drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98vb=
2_dc_mmap=E2=80=99:
drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit dec=
laration of function =E2=80=98dma_mmap_coherent=E2=80=99
drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98vb=
2_dc_get_base_sgt=E2=80=99:
drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit dec=
laration of function =E2=80=98dma_get_sgtable=E2=80=99

This series adds dma_mmap_coherent() and dma_get_sgtable() for all
architectures that set CONFIG_HAS_DMA=3Dy, but don't use dma_map_ops.

  - On architectures for which I received an ack (avr32, blackfin, cris=
,
    and m68k), the patches are unchanged compared to v1: dma_mmap_coher=
ent()
    and dma_get_sgtable() are implement as inline stubs using
    dma_common_mmap() and dma_common_get_sgtable().

  - On architectures where the current API cannot be implemented (paris=
c),
    dma_mmap_coherent() and dma_get_sgtable() are dummy implementations=
 that
    just return -EINVAL, until the API has been finalized.

  - On architectures for which I did not receive an ack (c6x, frv, mn10=
300,
    and xtensa), dma_mmap_coherent() and dma_get_sgtable() are dummy
    implementations that just return -EINVAL, too.

I'll add this to the m68k for-next branch, so hopefully we can get an
unbroken build in 3.8.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
