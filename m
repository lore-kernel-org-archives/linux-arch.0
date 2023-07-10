Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BABEB64D9
	for <linux-arch@archiver.kernel.org>; Mon, 10 Jul 2023 20:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjGJUpB (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 10 Jul 2023 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjGJUoF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCEAE72;
        Mon, 10 Jul 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F+ZlOZYXfLNjysRkosLQAF/h5hJm/ZmBQd5bhit3iG0=; b=HN1p+gEFEXL2I8SdOVwCy+Eoad
        oY5wyMKzIMjZhTic3XvCdeipBjThposExOtkyN4oekrhLmxN6ZymyArLOYJ+VSl4KhakWOI1/1nqE
        RT2qar+hBM7Ne2vF8t5D9eCiEWKvSlKQKsfaWCBBY8AXd2aK4IbGnhp+TV3Jr7h3xHeiff8XDrGUQ
        sLOPCde6Y2M2iPruUMowU4SXdBEYtZGRNPfhkrbNNKbDu4x6hdXhIyE7RnlxTSgySRCZJ27lXH73L
        3txlvo0r36dhsc3FNV1+BDXkTUctkFzxPOdMqCsWjJk5/j4m7pnssMhA8pQqbyPSBa2owsXhLEDo8
        dAV4KQLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjU-00Euqh-I4; Mon, 10 Jul 2023 20:43:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v5 30/38] mm: Remove page_mapping_file()
Date:   Mon, 10 Jul 2023 21:43:31 +0100
Message-Id: <20230710204339.3554919-31-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This function has no more users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pagemap.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 794e4e55dc38..71dd79b4ae0a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -414,14 +414,6 @@ static inline struct address_space *page_file_mapping(struct page *page)
 	return folio_file_mapping(page_folio(page));
 }
 
-/*
- * For file cache pages, return the address_space, otherwise return NULL
- */
-static inline struct address_space *page_mapping_file(struct page *page)
-{
-	return folio_flush_mapping(page_folio(page));
-}
-
 /**
  * folio_inode - Get the host inode for this folio.
  * @folio: The folio.
-- 
2.39.2

