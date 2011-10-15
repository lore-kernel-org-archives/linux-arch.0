Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:8350 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1JOWis (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2011 18:38:48 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p9FMckk3023452
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 15:38:46 -0700
Received: from pzk2 (pzk2.prod.google.com [10.243.19.130])
	by hpaq11.eem.corp.google.com with ESMTP id p9FMciRB007799
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 15:38:45 -0700
Received: by pzk2 with SMTP id 2so6472391pzk.4
        for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 15:38:43 -0700 (PDT)
Date: Sat, 15 Oct 2011 15:38:41 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: [patch] parisc, iommu: add missing include for prefetchw()
In-Reply-To: <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
Message-ID: <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20111015223841.IN_7WDLUc0VIS0q_C8Pu0e0wA21JRUS_4PIGuFBTV64@z>

prefetchw() requires it to be defined by linux/prefetch.h, or it results
in a compile error:

In file included from drivers/parisc/sba_iommu.c:916:0:
drivers/parisc/iommu-helpers.h: In function 'iommu_fill_pdir':
drivers/parisc/iommu-helpers.h:62:4: error: implicit declaration of function 'prefetchw'

Include linux/prefetch.h.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/parisc/iommu-helpers.h |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/parisc/iommu-helpers.h b/drivers/parisc/iommu-helpers.h
--- a/drivers/parisc/iommu-helpers.h
+++ b/drivers/parisc/iommu-helpers.h
@@ -1,3 +1,5 @@
+#include <linux/prefetch.h>
+
 /**
  * iommu_fill_pdir - Insert coalesced scatter/gather chunks into the I/O Pdir.
  * @ioc: The I/O Controller.
