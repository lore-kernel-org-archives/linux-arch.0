From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 20/73] arm: use subsys_initcall in non-modular pl320 IPC code
Date: Tue, 21 Jan 2014 16:22:23 -0500
Message-ID: <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

The drivers/mailbox/pl320-ipc.o is dependent on config PL320_MBOX
which is declared as a bool.  Hence the code is never going to be
modular.  So using module_init as an alias for __initcall can be
somewhat misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.  Also add an inclusion of init.h, as
that was previously implicit.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of subsys_initcall (which
seems to make sense for netfilter code) will thus change this
registration from level 6-device to level 4-subsys (i.e. slightly
earlier).  However no impact of that small difference is expected.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mailbox/pl320-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index d873cba..b2737a2 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -195,4 +195,4 @@ static int __init ipc_init(void)
 {
 	return amba_driver_register(&pl320_driver);
 }
-module_init(ipc_init);
+subsys_initcall(ipc_init);
-- 
1.8.4.1
