From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 03/19] firmware/ivc: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:13 -0700
Message-ID: <1508792849-3115-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

workqueue: kill off ACCESS_ONCE()

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't handle comments, leaving references
to ACCESS_ONCE() instances which have been removed. As a preparatory
step, this patch converts the Tegra IVC code and comments to use
{READ,WRITE}_ONCE() consistently.

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/firmware/tegra/ivc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/tegra/ivc.c b/drivers/firmware/tegra/ivc.c
index a01461d63f68..00de793e6423 100644
--- a/drivers/firmware/tegra/ivc.c
+++ b/drivers/firmware/tegra/ivc.c
@@ -99,11 +99,11 @@ static inline bool tegra_ivc_empty(struct tegra_ivc *ivc,
 {
 	/*
 	 * This function performs multiple checks on the same values with
-	 * security implications, so create snapshots with ACCESS_ONCE() to
+	 * security implications, so create snapshots with READ_ONCE() to
 	 * ensure that these checks use the same values.
 	 */
-	u32 tx = ACCESS_ONCE(header->tx.count);
-	u32 rx = ACCESS_ONCE(header->rx.count);
+	u32 tx = READ_ONCE(header->tx.count);
+	u32 rx = READ_ONCE(header->rx.count);
 
 	/*
 	 * Perform an over-full check to prevent denial of service attacks
@@ -124,8 +124,8 @@ static inline bool tegra_ivc_empty(struct tegra_ivc *ivc,
 static inline bool tegra_ivc_full(struct tegra_ivc *ivc,
 				  struct tegra_ivc_header *header)
 {
-	u32 tx = ACCESS_ONCE(header->tx.count);
-	u32 rx = ACCESS_ONCE(header->rx.count);
+	u32 tx = READ_ONCE(header->tx.count);
+	u32 rx = READ_ONCE(header->rx.count);
 
 	/*
 	 * Invalid cases where the counters indicate that the queue is over
@@ -137,8 +137,8 @@ static inline bool tegra_ivc_full(struct tegra_ivc *ivc,
 static inline u32 tegra_ivc_available(struct tegra_ivc *ivc,
 				      struct tegra_ivc_header *header)
 {
-	u32 tx = ACCESS_ONCE(header->tx.count);
-	u32 rx = ACCESS_ONCE(header->rx.count);
+	u32 tx = READ_ONCE(header->tx.count);
+	u32 rx = READ_ONCE(header->rx.count);
 
 	/*
 	 * This function isn't expected to be used in scenarios where an
@@ -151,8 +151,8 @@ static inline u32 tegra_ivc_available(struct tegra_ivc *ivc,
 
 static inline void tegra_ivc_advance_tx(struct tegra_ivc *ivc)
 {
-	ACCESS_ONCE(ivc->tx.channel->tx.count) =
-		ACCESS_ONCE(ivc->tx.channel->tx.count) + 1;
+	WRITE_ONCE(ivc->tx.channel->tx.count,
+		   READ_ONCE(ivc->tx.channel->tx.count) + 1);
 
 	if (ivc->tx.position == ivc->num_frames - 1)
 		ivc->tx.position = 0;
@@ -162,8 +162,8 @@ static inline void tegra_ivc_advance_tx(struct tegra_ivc *ivc)
 
 static inline void tegra_ivc_advance_rx(struct tegra_ivc *ivc)
 {
-	ACCESS_ONCE(ivc->rx.channel->rx.count) =
-		ACCESS_ONCE(ivc->rx.channel->rx.count) + 1;
+	WRITE_ONCE(ivc->rx.channel->rx.count,
+		   READ_ONCE(ivc->rx.channel->rx.count) + 1);
 
 	if (ivc->rx.position == ivc->num_frames - 1)
 		ivc->rx.position = 0;
@@ -428,7 +428,7 @@ int tegra_ivc_notified(struct tegra_ivc *ivc)
 
 	/* Copy the receiver's state out of shared memory. */
 	tegra_ivc_invalidate(ivc, ivc->rx.phys + offset);
-	state = ACCESS_ONCE(ivc->rx.channel->tx.state);
+	state = READ_ONCE(ivc->rx.channel->tx.state);
 
 	if (state == TEGRA_IVC_STATE_SYNC) {
 		offset = offsetof(struct tegra_ivc_header, tx.count);
-- 
2.5.2
