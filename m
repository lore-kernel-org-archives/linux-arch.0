Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90701BD035
	for <linux-arch@vger.kernel.org>; Wed,  4 Feb 2026 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240735; cv=none; b=aIxe4sOeMgnsxmfpgd8hUx4w4pbANOqlPdlsNBgQ6skmkHQLQbk4DY2Bcg57Jk7cV96xvEoDzUlShuFRKfOCwCIrcC7v+NPlsUIzMO25iCegbQG0mTb629VOgFW4hqDhZICxga0IvdWlFNvWpuaUIf6/xgV4cQfLHLxArRZIE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240735; c=relaxed/simple;
	bh=q/30h0yEPcWEiedOGg5w9e2G3+3wkVS5kXJ48vtVSbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xm19HOWZGteT6Reotcygk7lib+z7aTJVtFh/vnw9VRqp+5Xh4nosL3cFZ7hTZTSy0b2A8ijQ1EW5bEyOwXGF2jjHVFpNb2CCEXf9mGWdfsPUUMAgH70AczuphfhY1lZtwvSCdi0MTSht/fJuqzcmjzZAEDIo6HYqpjCTrUo/j+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id njiLvq3gvSkcfnkTovxO55; Wed, 04 Feb 2026 21:32:08 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id nkTnv1M4vSqlVnkTnvRY5Q; Wed, 04 Feb 2026 21:32:08 +0000
X-Authority-Analysis: v=2.4 cv=I7FlRMgg c=1 sm=1 tr=0 ts=6983bad8
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=uc9KWs4yn0V/JYYSH7YHpg==:17
 a=HzLeVaNsDn8A:10 a=z6gsHLkEAAAA:8 a=20KFwNOVAAAA:8 a=Xie9NPzdAAAA:8
 a=pwlSjyV6AAAA:8 a=SwvnC8opRPVetA8u2xwA:9 a=vUoOGYJDS1_Kmot3Fv_X:22
 a=J9--6epWBKc4EL46Yp3Y:22 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.46.62] (port=46610 helo=timdesk..)
	by host2044.hostmonster.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <tim.bird@sony.com>)
	id 1vnkTf-000000003WL-3RQZ;
	Wed, 04 Feb 2026 14:31:59 -0700
From: Tim Bird <tim.bird@sony.com>
To: kbusch@kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	aneesh.kumar@kernel.org,
	mike.kravetz@oracle.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	riel@surriel.com,
	torvalds@linuxfoundation.org,
	david@kernel.org,
	muchun.sony@linux.dev,
	osalvador@suse.de,
	hughd@google.com,
	will@kernel.org,
	npiggin@gmail.com
Cc: linux-spdx@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Bird <tim.bird@sony.com>
Subject: [PATCH] mm: Add SPDX id lines to some mm source files
Date: Wed,  4 Feb 2026 14:31:01 -0700
Message-ID: <20260204213101.1754183-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.46.62
X-Source-L: No
X-Exim-ID: 1vnkTf-000000003WL-3RQZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk..) [66.118.46.62]:46610
X-Source-Auth: tim@bird.org
X-Email-Count: 3
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfCTjgdXHx0rEyB/SfED/lL/aMhbyKj049NOif5bpuX5kq8BumXCQorXySxIqrVShh3aHcD3AZCgwCtPTq8YLEMvJtFaJgUQeY6XdXgBd2lkiaKFYW8NB
 MbuVikc8ysjkgx9tsKHiszT7wN+3GvZDHmlOXaFJ+y/I4aPYVztiMX+2sRUVNlSvpLyDrKzlI+sCbeDNkjOaCezeIgAHiaL3bLA=

Some of the memory management source files are missing
SPDX-License-Identifier lines.  Add appropriate IDs
to these files (mostly GPL-2.0, but one LGPL-2.1).

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 mm/dmapool_test.c   | 1 +
 mm/folio-compat.c   | 1 +
 mm/gup_test.c       | 1 +
 mm/hugetlb_cgroup.c | 9 +--------
 mm/memfd.c          | 3 +--
 mm/mmu_gather.c     | 1 +
 mm/rmap.c           | 2 +-
 mm/shmem.c          | 3 +--
 8 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/dmapool_test.c b/mm/dmapool_test.c
index 54b1fd1ccfbb..e8172d708308 100644
--- a/mm/dmapool_test.c
+++ b/mm/dmapool_test.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/device.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 45540942d148..a02179a0bded 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Compatibility functions which bloat the callers too much to make inline.
  * All of the callers of these functions should be converted to use folios
diff --git a/mm/gup_test.c b/mm/gup_test.c
index eeb3f4d87c51..9dd48db897b9 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 58e895f3899a..0a87cbbeeed9 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  *
  * Copyright IBM Corporation, 2012
@@ -7,14 +8,6 @@
  * Copyright (C) 2019 Red Hat, Inc.
  * Author: Giuseppe Scrivano <gscrivan@redhat.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2.1 of the GNU Lesser General Public License
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
  */
 
 #include <linux/cgroup.h>
diff --git a/mm/memfd.c b/mm/memfd.c
index ab5312aff14b..8f1f26de92f0 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * memfd_create system call and file sealing support
  *
  * Code was originally included in shmem.c, and broken out to facilitate
  * use by hugetlbfs as well as tmpfs.
- *
- * This file is released under the GPL.
  */
 
 #include <linux/fs.h>
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 247e3f9db6c7..fccba879f056 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
diff --git a/mm/rmap.c b/mm/rmap.c
index f955f02d570e..a91282020e77 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1,8 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mm/rmap.c - physical to virtual reverse mappings
  *
  * Copyright 2001, Rik van Riel <riel@conectiva.com.br>
- * Released under the General Public License (GPL).
  *
  * Simple, low overhead reverse mapping scheme.
  * Please try to keep this thing as modular as possible.
diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d..e460f41d26b9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Resizable virtual memory filesystem for Linux.
  *
@@ -17,8 +18,6 @@
  *
  * tiny-shmem:
  * Copyright (c) 2004, 2008 Matt Mackall <mpm@selenic.com>
- *
- * This file is released under the GPL.
  */
 
 #include <linux/fs.h>
-- 
2.43.0

