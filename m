Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:38622 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751042AbWCSVYY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 16:24:24 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
References: <1142788559.3240.30.camel@mulgrave.il.steeleye.com>
	 <20060319.123320.71795946.davem@davemloft.net>
	 <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
	 <20060319.130009.102283514.davem@davemloft.net>
	 <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 15:23:51 -0600
Message-Id: <1142803431.3240.58.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-03-19 at 15:04 -0600, James Bottomley wrote:
> OK, I confess to not ever having looked at that ... does it use
> get_user_pages() as well?

If the fix is to be in get_user_pages(), this is what works for parisc.

James

Index: mm/memory.c
===================================================================
RCS file: /var/cvs/linux-2.6/mm/memory.c,v
retrieving revision 1.46
diff -u -p -r1.46 memory.c
--- mm/memory.c	18 Feb 2006 05:40:32 -0000	1.46
+++ mm/memory.c	19 Mar 2006 21:23:19 -0000
@@ -1073,6 +1073,8 @@ int get_user_pages(struct task_struct *t
 			}
 			if (pages) {
 				pages[i] = page;
+				if (PageAnon(page))
+					flush_cache_page(vma, start, page_to_pfn(page));
 				flush_dcache_page(page);
 			}
 			if (vmas)


