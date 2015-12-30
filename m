From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 32/34] xen/io: use __smp_XXX barriers
Date: Wed, 30 Dec 2015 15:26:28 +0200
Message-ID: <1451473761-30019-33-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

include/xen/interface/io/ring.h uses
full memory barriers to communicate with the other side.

For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
would be sufficient, so mb() and wmb() here are only needed if
a non-SMP guest runs on an SMP host.

Switch to __smp_XXX barriers which serve this exact purpose.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/xen/interface/io/ring.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 7dc685b..46dfc65 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -208,12 +208,12 @@ struct __name##_back_ring {						\
 
 
 #define RING_PUSH_REQUESTS(_r) do {					\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    __smp_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = (_r)->req_prod_pvt;				\
 } while (0)
 
 #define RING_PUSH_RESPONSES(_r) do {					\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    __smp_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = (_r)->rsp_prod_pvt;				\
 } while (0)
 
@@ -250,9 +250,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->req_prod;				\
     RING_IDX __new = (_r)->req_prod_pvt;				\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    __smp_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = __new;					\
-    mb(); /* back sees new requests /before/ we check req_event */	\
+    __smp_mb(); /* back sees new requests /before/ we check req_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->req_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -260,9 +260,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->rsp_prod;				\
     RING_IDX __new = (_r)->rsp_prod_pvt;				\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    __smp_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = __new;					\
-    mb(); /* front sees new responses /before/ we check rsp_event */	\
+    __smp_mb(); /* front sees new responses /before/ we check rsp_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->rsp_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -271,7 +271,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->req_event = (_r)->req_cons + 1;			\
-    mb();								\
+    __smp_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
 } while (0)
 
@@ -279,7 +279,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->rsp_event = (_r)->rsp_cons + 1;			\
-    mb();								\
+    __smp_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
 } while (0)
 
-- 
MST
