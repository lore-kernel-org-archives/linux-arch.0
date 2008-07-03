From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 0/8] fix implicit declarations of PAGE_ALIGN() for different archs
Date: Thu,  3 Jul 2008 11:59:23 +0200
Message-ID: <1215079171-22637-1-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12596
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754231AbYGCMeT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 08:34:19 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com


Additional fixups against -mm and current page_align* patches in -mmotm, due to
the move of PAGE_ALIGN() from asm-*/page.h to linux/mm.h.

NOTE: these fixes have been found doing some greps in the code; this means the
build for all arch was *not* tested at all (except for allmodconfig,
allyesconfig and some randconfigs for x86 and x86_64), but they can prevent
many potential building failures.

-Andrea
