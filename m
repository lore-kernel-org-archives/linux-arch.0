From: David Rientjes <rientjes@google.com>
Subject: [patch] parisc, iommu: add missing include for prefetchw()
Date: Sat, 15 Oct 2011 15:38:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
