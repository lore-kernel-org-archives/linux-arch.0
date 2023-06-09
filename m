Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D668C7EE29
	for <linux-arch@archiver.kernel.org>; Fri,  9 Jun 2023 08:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbjFIIAA (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 9 Jun 2023 04:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbjFIH7l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 03:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB044B2
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRjmDB/MhJX2uAhXZR6PcmrnbkF0aNZomeUUr4ZAM3o=;
        b=NbYybZwIRGDTXpSOOkx43P9kYFStKP4GX8VkOzz5GENzdshU6uSMGJkuHDUePN75BbvDgv
        JGs3Pzy6sHdKeyxSzH0UbN5xvum+UgynBxVA5jwwKYJ6xK9EWPIbvg8myIG0DSAEck4+4p
        wftgOGfAQxwXd2UqyDw36v6h8/if0fE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-Rqd3XGSRMJmpF0VEV5s9pg-1; Fri, 09 Jun 2023 03:57:24 -0400
X-MC-Unique: Rqd3XGSRMJmpF0VEV5s9pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEC4280120A;
        Fri,  9 Jun 2023 07:57:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 244B620268C6;
        Fri,  9 Jun 2023 07:57:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 15/19] mm/ioremap: Consider IOREMAP space in generic ioremap
Date:   Fri,  9 Jun 2023 15:55:24 +0800
Message-Id: <20230609075528.9390-16-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Architectures like powerpc have a dedicated space for IOREMAP mappings.

If so, use it in generic_ioremap_prot().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v5->v6:
  Add definition of IOREMAP_START|END in mm/ioremap.c so that
  we can call __get_vm_area_caller() for all ARCH-es - Christoph
  
 mm/ioremap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 86b82ec27d2b..68d9895144ad 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -11,6 +11,15 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
+/*
+ * Ioremap often, but not always uses the generic vmalloc area. E.g on
+ * Power ARCH, it could have different ioremap space.
+ */
+#ifndef IOREMAP_START
+#define IOREMAP_START   VMALLOC_START
+#define IOREMAP_END     VMALLOC_END
+#endif
+
 void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 				   pgprot_t prot)
 {
@@ -35,8 +44,8 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
 		return NULL;
 
-	area = get_vm_area_caller(size, VM_IOREMAP,
-			__builtin_return_address(0));
+	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
+				    IOREMAP_END, __builtin_return_address(0));
 	if (!area)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
@@ -66,7 +75,7 @@ void generic_iounmap(volatile void __iomem *addr)
 	if (!iounmap_allowed(vaddr))
 		return;
 
-	if (is_vmalloc_addr(vaddr))
+	if (is_ioremap_addr(vaddr))
 		vunmap(vaddr);
 }
 
-- 
2.34.1

