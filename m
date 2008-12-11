From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 04/19] alpha: rename .data.init_thread to .data.init_task
Date: Thu, 11 Dec 2008 03:52:42 +0000
Message-ID: <088318acd2a7993a8334254f2a5f6a57c22a442d.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
 <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
 <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57670 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbYLKDx1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:27 -0500
In-Reply-To: <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, ink@jurassic.park.msu.ru, rth@twiddle.net, Kyle McMartin <kyle@redhat.com>

Everyone else calls it .init_task, and it's one less special case
for a generic kernel/init_task.c...

Cc: ink@jurassic.park.msu.ru
Cc: rth@twiddle.net
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/alpha/kernel/init_task.c   |    2 +-
 arch/alpha/kernel/vmlinux.lds.S |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/init_task.c b/arch/alpha/kernel/init_task.c
index 1f76218..901a0e2 100644
--- a/arch/alpha/kernel/init_task.c
+++ b/arch/alpha/kernel/init_task.c
@@ -18,5 +18,5 @@ EXPORT_SYMBOL(init_mm);
 EXPORT_SYMBOL(init_task);
 
 union thread_union init_thread_union
-	__attribute__((section(".data.init_thread")))
+	__attribute__((section(".data.init_task")))
 	= { INIT_THREAD_INFO(init_task) };
diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index ef37fc1..563c8d1 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -93,8 +93,8 @@ SECTIONS
 	/* Freed after init ends here */
 
 	/* Note 2 page alignment above.  */
-	.data.init_thread : {
-		*(.data.init_thread)
+	.data.init_task : {
+		*(.data.init_task)
 	}
 
 	. = ALIGN(PAGE_SIZE);
-- 
1.6.0.4
