From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 03/11] openrisc: Export __clear_user to modules
Date: Fri, 7 Aug 2015 16:21:56 +0100
Message-ID: <1438960924-23628-4-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

Update the OpenRISC architecture code to export __clear_user() to
modules, so that modules can make use of clear_user(). For example the
test_user_copy module will soon test it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux@lists.openrisc.net
---
 arch/openrisc/kernel/or32_ksyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 83ccf7c0c58d..54eae8b40fda 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -44,3 +44,4 @@ DECLARE_EXPORT(__ashldi3);
 DECLARE_EXPORT(__lshrdi3);
 
 EXPORT_SYMBOL(__copy_tofrom_user);
+EXPORT_SYMBOL(__clear_user);
-- 
2.3.6
