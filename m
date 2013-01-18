From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 08/76] asm-generic headers: Allow yet more arch overrides in checksum.h
Date: Fri, 18 Jan 2013 17:54:22 +0530
Message-ID: <1358511930-7424-9-git-send-email-vgupta@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

arches can have more efficient implementation of these routines

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/checksum.h |    4 ++++
 lib/checksum.c                 |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index c084767..59811df 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -38,12 +38,15 @@ extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
 	csum_partial_copy((src), (dst), (len), (sum))
 #endif
 
+#ifndef ip_fast_csum
 /*
  * This is a version of ip_compute_csum() optimized for IP headers,
  * which always checksum on 4 octet boundaries.
  */
 extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
+#endif
 
+#ifndef csum_fold
 /*
  * Fold a partial checksum
  */
@@ -54,6 +57,7 @@ static inline __sum16 csum_fold(__wsum csum)
 	sum = (sum & 0xffff) + (sum >> 16);
 	return (__force __sum16)~sum;
 }
+#endif
 
 #ifndef csum_tcpudp_nofold
 /*
diff --git a/lib/checksum.c b/lib/checksum.c
index 12dceb2..129775e 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -102,6 +102,7 @@ out:
 }
 #endif
 
+#ifndef ip_fast_csum
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
@@ -111,6 +112,7 @@ __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	return (__force __sum16)~do_csum(iph, ihl*4);
 }
 EXPORT_SYMBOL(ip_fast_csum);
+#endif
 
 /*
  * computes the checksum of a memory block at buff, length len,
-- 
1.7.4.1
