From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 02/15] tty: ldsem_cmpxchg() should use cmpxchg() not
 atomic_long_cmpxchg()
Date: Wed, 18 May 2016 16:10:52 +0100
Message-ID: <146358425242.8596.10719266273243587481.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbcERPKz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 May 2016 11:10:55 -0400
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

ldsem_cmpxchg() should use cmpxchg() not atomic_long_cmpxchg() since the
variable it is wangling isn't an atomic_long_t.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Peter Hurley <peter@hurleysoftware.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 drivers/tty/tty_ldsem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 1bf8ed13f827..dc27b285ba4f 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -86,7 +86,7 @@ static inline long ldsem_atomic_update(long delta, struct ld_semaphore *sem)
  */
 static inline int ldsem_cmpxchg(long *old, long new, struct ld_semaphore *sem)
 {
-	long tmp = atomic_long_cmpxchg(&sem->count, *old, new);
+	long tmp = cmpxchg(&sem->count, *old, new);
 	if (tmp == *old) {
 		*old = new;
 		return 1;
