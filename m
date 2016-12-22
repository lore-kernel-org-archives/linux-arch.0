Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46205 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932213AbcLVVTW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Dec 2016 16:19:22 -0500
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH v2 1/4] dax: kill uml support
Date: Thu, 22 Dec 2016 14:18:53 -0700
Message-ID: <1482441536-14550-2-git-send-email-ross.zwisler@linux.intel.com>
In-Reply-To: <1482441536-14550-1-git-send-email-ross.zwisler@linux.intel.com>
References: <1482441536-14550-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@intel.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox <mawilcox@microsoft.com>, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20161222211853.atLVL3X0eDk327wE0h9o4AglPH7gzDbnOXZZ0qvRAlQ@z>

From: Dan Williams <dan.j.williams@intel.com>

The lack of common transparent-huge-page helpers for UML is becoming
increasingly painful for fs/dax.c now that it is growing more pmd
functionality. Add UML to the list of unsupported architectures.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[rez: squashed #ifdef removal into another patch in the series ]
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index c2a377c..661931f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -37,7 +37,7 @@ source "fs/f2fs/Kconfig"
 config FS_DAX
 	bool "Direct Access (DAX) support"
 	depends on MMU
-	depends on !(ARM || MIPS || SPARC)
+	depends on !(ARM || MIPS || SPARC || UML)
 	help
 	  Direct Access (DAX) can be used on memory-backed block devices.
 	  If the block device supports DAX and the filesystem supports DAX,
-- 
2.7.4

