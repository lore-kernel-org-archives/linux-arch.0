From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 01/11] microblaze: Export __strnlen_user to modules
Date: Fri, 7 Aug 2015 16:21:54 +0100
Message-ID: <1438960924-23628-2-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>
List-Id: linux-arch.vger.kernel.org

Update the microblaze architecture code to export __strnlen_user() to
modules, so they can make use of strnlen_user(). For example the
test_user_copy module will soon test it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/microblaze_ksyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/kernel/microblaze_ksyms.c b/arch/microblaze/kernel/microblaze_ksyms.c
index 9f1d02c4c5cc..baf7a2340d97 100644
--- a/arch/microblaze/kernel/microblaze_ksyms.c
+++ b/arch/microblaze/kernel/microblaze_ksyms.c
@@ -31,6 +31,7 @@ EXPORT_SYMBOL(_mcount);
  */
 EXPORT_SYMBOL(__copy_tofrom_user);
 EXPORT_SYMBOL(__strncpy_user);
+EXPORT_SYMBOL(__strnlen_user);
 
 #ifdef CONFIG_OPT_LIB_ASM
 EXPORT_SYMBOL(memcpy);
-- 
2.3.6
