Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:27354 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932142AbWCSRQK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 12:16:10 -0500
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k2JHFx223254
	for <linux-arch@vger.kernel.org>; Sun, 19 Mar 2006 12:15:59 -0500
Subject: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 11:15:58 -0600
Message-Id: <1142788559.3240.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This issue came up while investigating why fuse doesn't work on parisc.

The problem, essentially is that get_user_pages() doesn't return a
coherent view of anonymous pages to the kernel.  The reason is that
get_user_pages() uses flush_dcache_page() as its engine of coherence,
and a lot of flush_dcache_page() implementations use the page_mapping()
macros to get a list of user mappings of the page.  The page_mapping()
macro (include/linux/mm.h) returns NULL if the PAGE_MAPPING_ANON flag is
set, this means that flush_dcache_page() has no list of user mappings,
so nothing gets flushed in user space.

A lot of arch's don't have an incoherent view of user and kernel
mappings, so I think this problem perhaps affects only parisc and arm.

It seems to me that once get_user_pages() has executed, we should have a
guarantee that the kernel has a coherent view of all the pages so
returned, so either flush_dcache_page() should iterate over anonymous
page mappings (my preferred solution) or get_user_pages() should have
additional coherency for anonymous pages.

Although this problem first manifested with fuse, I think we would have
a similar issue doing SG_IO on memory obtained from brk, so we're lucky
it hasn't bitten us before.

James


