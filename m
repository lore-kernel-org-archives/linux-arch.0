From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/13] Make xfrm functions that return a boolean value
 return bool
Date: Wed, 29 Apr 2015 20:22:52 +0100
Message-ID: <20150429192252.24909.49543.stgit@warthog.procyon.org.uk>
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

Make xfrm functions that return a boolean value return bool to allow gcc to
make better decisions.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/net/xfrm.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 36ac102c97c7..8b2d3683d4e1 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1658,10 +1658,10 @@ static inline int xfrm_policy_id2dir(u32 index)
 }
 
 #ifdef CONFIG_XFRM
-static inline int xfrm_aevent_is_on(struct net *net)
+static inline bool xfrm_aevent_is_on(struct net *net)
 {
 	struct sock *nlsk;
-	int ret = 0;
+	bool ret = false;
 
 	rcu_read_lock();
 	nlsk = rcu_dereference(net->xfrm.nlsk);
@@ -1671,10 +1671,10 @@ static inline int xfrm_aevent_is_on(struct net *net)
 	return ret;
 }
 
-static inline int xfrm_acquire_is_on(struct net *net)
+static inline bool xfrm_acquire_is_on(struct net *net)
 {
 	struct sock *nlsk;
-	int ret = 0;
+	int ret = false;
 
 	rcu_read_lock();
 	nlsk = rcu_dereference(net->xfrm.nlsk);
