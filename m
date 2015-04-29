From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/13] Make nodemask functions that return a boolean value
 return bool
Date: Wed, 29 Apr 2015 20:22:03 +0100
Message-ID: <20150429192203.24909.84448.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make nodemask functions that return a boolean value return bool as this allows
gcc to make better choices.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/nodemask.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 6e85889cf9ab..520dcb59f53d 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -141,7 +141,7 @@ static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 
 #define node_test_and_set(node, nodemask) \
 			__node_test_and_set((node), &(nodemask))
-static inline int __node_test_and_set(int node, nodemask_t *addr)
+static inline bool __node_test_and_set(int node, nodemask_t *addr)
 {
 	return test_and_set_bit(node, addr->bits);
 }
@@ -188,7 +188,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
 
 #define nodes_equal(src1, src2) \
 			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_equal(const nodemask_t *src1p,
+static inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
@@ -196,7 +196,7 @@ static inline int __nodes_equal(const nodemask_t *src1p,
 
 #define nodes_intersects(src1, src2) \
 			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_intersects(const nodemask_t *src1p,
+static inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
@@ -204,20 +204,20 @@ static inline int __nodes_intersects(const nodemask_t *src1p,
 
 #define nodes_subset(src1, src2) \
 			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_subset(const nodemask_t *src1p,
+static inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
 #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
-static inline int __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
+static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
 #define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
-static inline int __nodes_full(const nodemask_t *srcp, unsigned int nbits)
+static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
@@ -395,7 +395,7 @@ enum node_states {
 extern nodemask_t node_states[NR_NODE_STATES];
 
 #if MAX_NUMNODES > 1
-static inline int node_state(int node, enum node_states state)
+static inline bool node_state(int node, enum node_states state)
 {
 	return node_isset(node, node_states[state]);
 }
@@ -446,7 +446,7 @@ static inline void node_set_offline(int nid)
 
 #else
 
-static inline int node_state(int node, enum node_states state)
+static inline bool node_state(int node, enum node_states state)
 {
 	return node == 0;
 }
