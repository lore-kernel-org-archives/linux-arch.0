From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 08/11] xfs: Use *_dec_not_zero instead of *_add_unless
Date: Wed, 27 Jul 2011 11:47:47 +0200
Message-ID: <1311760070-21532-8-git-send-email-sven@narfation.org>
References: <1311760070-21532-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <1311760070-21532-1-git-send-email-sven@narfation.org>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Sender: xfs-bounces@oss.sgi.com
Errors-To: xfs-bounces@oss.sgi.com
To: linux-arch@vger.kernel.org
Cc: xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, Alex Elder <aelder@sgi.com>
List-Id: linux-arch.vger.kernel.org

atomic_dec_not_zero is defined for each architecture through
<linux/atomic.h> to provide the functionality of
atomic_add_unless(x, -1, 0).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Alex Elder <aelder@sgi.com>
Cc: xfs-masters@oss.sgi.com
Cc: xfs@oss.sgi.com
---
 fs/xfs/linux-2.6/xfs_buf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index b2b4119..a68d9bf 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -1429,7 +1429,7 @@ xfs_buftarg_shrink(
 		 * zero. If the value is already zero, we need to reclaim the
 		 * buffer, otherwise it gets another trip through the LRU.
 		 */
-		if (!atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
+		if (!atomic_dec_not_zero(&bp->b_lru_ref)) {
 			list_move_tail(&bp->b_lru, &btp->bt_lru);
 			continue;
 		}
-- 
1.7.5.4

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
