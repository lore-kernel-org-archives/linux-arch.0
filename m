From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 06/19] media: dvb_ringbuffer: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:16 -0700
Message-ID: <1508792849-3115-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

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
step, this patch converts the DVB ringbuffer code and comments to use
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
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/dvb-core/dvb_ringbuffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c b/drivers/media/dvb-core/dvb_ringbuffer.c
index 2322af1b8742..53011629c9ad 100644
--- a/drivers/media/dvb-core/dvb_ringbuffer.c
+++ b/drivers/media/dvb-core/dvb_ringbuffer.c
@@ -66,12 +66,12 @@ ssize_t dvb_ringbuffer_free(struct dvb_ringbuffer *rbuf)
 {
 	ssize_t free;
 
-	/* ACCESS_ONCE() to load read pointer on writer side
+	/* READ_ONCE() to load read pointer on writer side
 	 * this pairs with smp_store_release() in dvb_ringbuffer_read(),
 	 * dvb_ringbuffer_read_user(), dvb_ringbuffer_flush(),
 	 * or dvb_ringbuffer_reset()
 	 */
-	free = ACCESS_ONCE(rbuf->pread) - rbuf->pwrite;
+	free = READ_ONCE(rbuf->pread) - rbuf->pwrite;
 	if (free <= 0)
 		free += rbuf->size;
 	return free-1;
@@ -143,7 +143,7 @@ ssize_t dvb_ringbuffer_read_user(struct dvb_ringbuffer *rbuf, u8 __user *buf, si
 		todo -= split;
 		/* smp_store_release() for read pointer update to ensure
 		 * that buf is not overwritten until read is complete,
-		 * this pairs with ACCESS_ONCE() in dvb_ringbuffer_free()
+		 * this pairs with READ_ONCE() in dvb_ringbuffer_free()
 		 */
 		smp_store_release(&rbuf->pread, 0);
 	}
@@ -168,7 +168,7 @@ void dvb_ringbuffer_read(struct dvb_ringbuffer *rbuf, u8 *buf, size_t len)
 		todo -= split;
 		/* smp_store_release() for read pointer update to ensure
 		 * that buf is not overwritten until read is complete,
-		 * this pairs with ACCESS_ONCE() in dvb_ringbuffer_free()
+		 * this pairs with READ_ONCE() in dvb_ringbuffer_free()
 		 */
 		smp_store_release(&rbuf->pread, 0);
 	}
-- 
2.5.2
