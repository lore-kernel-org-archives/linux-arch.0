From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: dma-mapping commit breaks UML
Date: Wed, 29 Sep 2010 11:55:30 +0200
Message-ID: <201009291155.30873.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:52906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751089Ab0I2Jzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2010 05:55:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: fujita.tomonori@lab.ntt.co.jp
Cc: linux-arch@vger.kernel.org

The=20

4565f0170dfc849b3629c27d769db800467baa62 is the first bad commit
commit 4565f0170dfc849b3629c27d769db800467baa62
Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date:   Tue Aug 10 18:03:22 2010 -0700

    dma-mapping: unify dma_get_cache_alignment implementations
   =20

It produces this compile error for ARCH=3Dum  :
=2E..
  CC      init/do_mounts.o
In file included from include/linux/dmaengine.h:27,
                 from include/linux/skbuff.h:31,
                 from include/linux/icmpv6.h:83,
                 from include/linux/ipv6.h:221,
                 from include/net/ipv6.h:17,
                 from include/linux/sunrpc/clnt.h:26,
                 from include/linux/nfs_fs.h:49,
                 from init/do_mounts.c:21:
include/linux/dma-mapping.h:145: error: redefinition of=20
=E2=80=98dma_get_cache_alignment=E2=80=99
/home/tfoerste/devel/linux-2.6/arch/um/include/asm/dma-mapping.h:100: n=
ote:=20
previous definition of =E2=80=98dma_get_cache_alignment=E2=80=99 was he=
re
make[1]: *** [init/do_mounts.o] Error 1
make: *** [init] Error 2

--=20
MfG/Kind regards
Toralf F=C3=B6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
