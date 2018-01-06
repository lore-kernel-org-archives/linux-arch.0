Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:34329 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753938AbeAFBTk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jan 2018 20:19:40 -0500
Subject: [PATCH 17/18] udf: prevent bounds-check bypass via speculative
 execution
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 05 Jan 2018 17:11:26 -0800
Message-ID: <151520108644.32271.711751583164644933.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, Jan Kara <jack@suse.com>, tglx@linutronix.de, torvalds@linux-foundation.org, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
Message-ID: <20180106011126.WXI6p8gkttjl6rzS_kPZoNSXB1NyExbCwkfGOpj6lN0@z>

Static analysis reports that 'eahd->appAttrLocation' and
'eahd->impAttrLocation' may be a user controlled values that are used as
data dependencies for calculating source and destination buffers for
memmove operations. In order to avoid potential leaks of kernel memory
values, block speculative execution of the instruction stream that could
issue further reads based on invalid 'aal' or 'ial' values.

Based on an original patch by Elena Reshetova.

Cc: Jan Kara <jack@suse.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/udf/misc.c |   39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 401e64cde1be..9403160822de 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -51,6 +51,8 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 	int offset;
 	uint16_t crclen;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	uint8_t *ea_dst, *ea_src;
+	uint32_t aal, ial;
 
 	ea = iinfo->i_ext.i_data;
 	if (iinfo->i_lenEAttr) {
@@ -100,33 +102,34 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 
 		offset = iinfo->i_lenEAttr;
 		if (type < 2048) {
-			if (le32_to_cpu(eahd->appAttrLocation) <
-					iinfo->i_lenEAttr) {
-				uint32_t aal =
-					le32_to_cpu(eahd->appAttrLocation);
-				memmove(&ea[offset - aal + size],
-					&ea[aal], offset - aal);
+			aal = le32_to_cpu(eahd->appAttrLocation);
+			if ((ea_dst = nospec_array_ptr(ea, offset - aal + size,
+						       iinfo->i_lenEAttr)) &&
+			    (ea_src = nospec_array_ptr(ea, aal,
+						       iinfo->i_lenEAttr))) {
+				memmove(ea_dst, ea_src, offset - aal);
 				offset -= aal;
 				eahd->appAttrLocation =
 						cpu_to_le32(aal + size);
 			}
-			if (le32_to_cpu(eahd->impAttrLocation) <
-					iinfo->i_lenEAttr) {
-				uint32_t ial =
-					le32_to_cpu(eahd->impAttrLocation);
-				memmove(&ea[offset - ial + size],
-					&ea[ial], offset - ial);
+
+			ial = le32_to_cpu(eahd->impAttrLocation);
+			if ((ea_dst = nospec_array_ptr(ea, offset - ial + size,
+						       iinfo->i_lenEAttr)) &&
+			    (ea_src = nospec_array_ptr(ea, ial,
+						       iinfo->i_lenEAttr))) {
+				memmove(ea_dst, ea_src, offset - ial);
 				offset -= ial;
 				eahd->impAttrLocation =
 						cpu_to_le32(ial + size);
 			}
 		} else if (type < 65536) {
-			if (le32_to_cpu(eahd->appAttrLocation) <
-					iinfo->i_lenEAttr) {
-				uint32_t aal =
-					le32_to_cpu(eahd->appAttrLocation);
-				memmove(&ea[offset - aal + size],
-					&ea[aal], offset - aal);
+			aal = le32_to_cpu(eahd->appAttrLocation);
+			if ((ea_dst = nospec_array_ptr(ea, offset - aal + size,
+						       iinfo->i_lenEAttr)) &&
+			    (ea_src = nospec_array_ptr(ea, aal,
+						       iinfo->i_lenEAttr))) {
+				memmove(ea_dst, ea_src, offset - aal);
 				offset -= aal;
 				eahd->appAttrLocation =
 						cpu_to_le32(aal + size);
