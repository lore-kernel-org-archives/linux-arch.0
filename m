From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: next-0402: build fails at mm/debug-pagealloc.c
Date: Thu, 2 Apr 2009 15:21:25 +0400
Message-ID: <a4423d670904020421k7395e11dwe70d4223cb817e0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
