From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 03/11] fault_inject: Remove private define of atomic_dec_not_zero
Date: Wed, 27 Jul 2011 11:47:42 +0200
Message-ID: <1311760070-21532-3-git-send-email-sven@narfation.org>
References: <1311760070-21532-1-git-send-email-sven@narfation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311760070-21532-1-git-send-email-sven@narfation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: linux-arch.vger.kernel.org

atomic_dec_not_zero is defined through <linux/atomic.h> for all
architectures and fault_inject doesn't need an extra define which may
collide with the global one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 lib/fault-inject.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 2577b12..8ce98c6 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -45,8 +45,6 @@ static void fail_dump(struct fault_attr *attr)
 		dump_stack();
 }
 
-#define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)
-
 static bool fail_task(struct fault_attr *attr, struct task_struct *task)
 {
 	return !in_interrupt() && task->make_it_fail;
-- 
1.7.5.4
