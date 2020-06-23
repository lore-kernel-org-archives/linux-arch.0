From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] make asm-generic/cacheflush.h more standalone
Date: Tue, 23 Jun 2020 13:57:14 +1000
Message-ID: <20200623135714.4dae4b8a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gxL3=hDPdEgWdgdriEUXhr+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:37851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbgFWD5T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 23:57:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

--Sig_/gxL3=hDPdEgWdgdriEUXhr+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Some s390 builds get these warnings:

include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct' declare=
d inside parameter list will not be visible outside of this definition or d=
eclaration
include/asm-generic/cacheflush.h:22:46: warning: 'struct mm_struct' declare=
d inside parameter list will not be visible outside of this definition or d=
eclaration
include/asm-generic/cacheflush.h:28:45: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
include/asm-generic/cacheflush.h:36:44: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
include/asm-generic/cacheflush.h:44:45: warning: 'struct page' declared ins=
ide parameter list will not be visible outside of this definition or declar=
ation
include/asm-generic/cacheflush.h:52:50: warning: 'struct address_space' dec=
lared inside parameter list will not be visible outside of this definition =
or declaration
include/asm-generic/cacheflush.h:58:52: warning: 'struct address_space' dec=
lared inside parameter list will not be visible outside of this definition =
or declaration
include/asm-generic/cacheflush.h:75:17: warning: 'struct page' declared ins=
ide parameter list will not be visible outside of this definition or declar=
ation
include/asm-generic/cacheflush.h:74:45: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
include/asm-generic/cacheflush.h:82:16: warning: 'struct page' declared ins=
ide parameter list will not be visible outside of this definition or declar=
ation
include/asm-generic/cacheflush.h:81:50: warning: 'struct vm_area_struct' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration

Forward declare the named structs to get rid of these.

Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush=
.h")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-generic/cacheflush.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cachefl=
ush.h
index 907fa5d16494..4a674db4e1fa 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
=20
+struct mm_struct;
+struct vm_area_struct;
+struct page;
+struct address_space;
+
 /*
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
--=20
2.27.0

--=20
Cheers,
Stephen Rothwell

--Sig_/gxL3=hDPdEgWdgdriEUXhr+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7xfZoACgkQAVBC80lX
0Gz5jAf/TGFJGFjGN3TkM/wWdczKpOSNE/vrqZGpIBaG68WZWv1hno3xS2NBYppg
luuXUwLZsA5afsboen5N1BE4n4yBiqk55ySVNI73QGoW7UC9itB10O2/zafkVq3u
vLoYV0LLLPpxBsGEiEIoh1YlCu8UBPVRY/MJkH9vVqF+fvTBylFjsOuOFjxTGGMM
QvXnWPrm6kpeABa3OFzmr8hUnSjCTKbMdRMrJY/8rMUSB+YItIUsqPX1+WKW9jwl
FsO4gkf8bQT2deOUR9rGwP67ypW5kHln2q+WcqZ3wzwmmYq/mTgreyG4bnCKmIeR
+dZh2Qf3fkr8DLzekHAayhvTIFn2yA==
=vDO3
-----END PGP SIGNATURE-----

--Sig_/gxL3=hDPdEgWdgdriEUXhr+--
