Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44330 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758433AbXGYLhn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 07:37:43 -0400
Date: Wed, 25 Jul 2007 13:37:42 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: [patch 3/7] wait_bit: use lock bitops
Message-ID: <20070725113742.GI29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070725113407.GG29011@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>


Convert __wait_on_bit_lock to new locking bitops. (OTOH, is it possible
that some callers expect a full smp_mb() semantics? I don't think so,
but maybe?)


Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 kernel/wait.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/wait.c
===================================================================
--- linux-2.6.orig/kernel/wait.c
+++ linux-2.6/kernel/wait.c
@@ -195,7 +195,7 @@ __wait_on_bit_lock(wait_queue_head_t *wq
 			if ((ret = (*action)(q->key.flags)))
 				break;
 		}
-	} while (test_and_set_bit(q->key.bit_nr, q->key.flags));
+	} while (test_and_set_bit_lock(q->key.bit_nr, q->key.flags));
 	finish_wait(wq, &q->wait);
 	return ret;
 }
