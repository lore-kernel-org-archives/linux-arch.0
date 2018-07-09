From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [RESEND PATCH v2] devres: Really align data field to unsigned long long
Date: Mon,  9 Jul 2018 07:44:44 +0300
Message-ID: <20180709044444.6397-1-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Depending on ABI "long long" type of a particular 32-bit CPU
might be aligned by either word (32-bits) or double word (64-bits).
Make sure "data" is really 64-bit aligned for any 32-bit CPU.

At least for 32-bit ARC cores ABI requires "long long" types
to be aligned by normal 32-bit word. This makes "data" field aligned to
12 bytes. Which is still OK as long as we use 32-bit data only.

But once we want to use native atomic64_t type (i.e. when we use special
instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
misaligned access exception.

That's because even on CPUs capable of non-aligned data access LL/SC
instructions require strict alignment.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---

Changes v1 -> v2:

 * Reworded commit message
 * Inserted comment right in source [Thomas]

 drivers/base/devres.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..466fa59c866a 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -24,8 +24,12 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	/*
+	 * Depending on ABI "long long" type of a particular 32-bit CPU
+	 * might be aligned by either word (32-bits) or double word (64-bits).
+	 * Make sure "data" is really 64-bit aligned for any 32-bit CPU.
+	 */
+	unsigned long long		data[] __aligned(sizeof(unsigned long long));
 };
 
 struct devres_group {
-- 
2.17.1
