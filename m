Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEWIsO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 04:48:14 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3] spdxcheck.py: Fix directory structures
Date: Thu, 23 May 2019 09:47:55 +0100
Message-Id: <20190523084755.56739-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, tglx@linutronix.de, jcline@redhat.com, geert@linux-m68k.org, joe@perches.com, hch@lst.de, vincenzo.frascino@arm.com

The LICENSE directory has recently changed structure and this makes
spdxcheck fails as per below:

FAIL: "Blob or Tree named 'other' not found"
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 240, in <module>
spdx = read_spdxdata(repo)
  File "scripts/spdxcheck.py", line 41, in read_spdxdata
for el in lictree[d].traverse():
[...]
KeyError: "Blob or Tree named 'other' not found"

Fix the script to restore the correctness on checkpatch License
checking.

References: 62be257e986d ("LICENSES: Rename other to deprecated")
References: 8ea8814fcdcb ("LICENSES: Clearly mark dual license only licenses")
Cc: Joe Perches <joe@perches.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeremy Cline <jcline@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 scripts/spdxcheck.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 33df646618e2..6374e078a5f2 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,7 +32,8 @@ class SPDXdata(object):
 def read_spdxdata(repo):
 
     # The subdirectories of LICENSES in the kernel source
-    license_dirs = [ "preferred", "deprecated", "exceptions", "dual" ]
+    # Note: exceptions needs to be parsed as last directory.
+    license_dirs = [ "preferred", "dual", "deprecated", "exceptions" ]
     lictree = repo.head.commit.tree['LICENSES']
 
     spdx = SPDXdata()
@@ -58,13 +59,13 @@ def read_spdxdata(repo):
                 elif l.startswith('SPDX-Licenses:'):
                     for lic in l.split(':')[1].upper().strip().replace(' ', '').replace('\t', '').split(','):
                         if not lic in spdx.licenses:
-                            raise SPDXException(None, 'Exception %s missing license %s' %(ex, lic))
+                            raise SPDXException(None, 'Exception %s missing license %s' %(exception, lic))
                         spdx.exceptions[exception].append(lic)
 
                 elif l.startswith("License-Text:"):
                     if exception:
                         if not len(spdx.exceptions[exception]):
-                            raise SPDXException(el, 'Exception %s is missing SPDX-Licenses' %excid)
+                            raise SPDXException(el, 'Exception %s is missing SPDX-Licenses' %exception)
                         spdx.exception_files += 1
                     else:
                         spdx.license_files += 1
-- 
2.21.0
