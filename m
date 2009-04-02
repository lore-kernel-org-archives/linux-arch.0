Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:35507 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935984AbZDBLV3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2009 07:21:29 -0400
MIME-Version: 1.0
Date: Thu, 2 Apr 2009 15:21:25 +0400
Message-ID: <a4423d670904020421k7395e11dwe70d4223cb817e0a@mail.gmail.com>
Subject: next-0402: build fails at mm/debug-pagealloc.c
From: Alexander Beregalov <a.beregalov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20090402112125.CTxtSUzmExwPJ_DEcTLgJryWMJJpkis39HzE0og37fk@z>

mm/debug-pagealloc.c: In function 'set_page_poison':
mm/debug-pagealloc.c:8: error: 'struct page' has no member named 'debug_flags'
mm/debug-pagealloc.c: In function 'clear_page_poison':
mm/debug-pagealloc.c:13: error: 'struct page' has no member named 'debug_flags'
mm/debug-pagealloc.c: In function 'page_poison':
mm/debug-pagealloc.c:18: error: 'struct page' has no member named 'debug_flags'
mm/debug-pagealloc.c: At top level:
mm/debug-pagealloc.c:120: error: redefinition of 'kernel_map_pages'
include/linux/mm.h:1278: error: previous definition of
'kernel_map_pages' was here
mm/debug-pagealloc.c: In function 'kernel_map_pages':
mm/debug-pagealloc.c:122: error: 'debug_pagealloc_enabled' undeclared
(first use in this function)

Should debug_flags really be in vm_area_struct instead of `struct page` ?
