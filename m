From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: ia64: hp: sim: sprintf() memory overflow, need really
 use the default value just as it has already said.
Date: Thu, 30 May 2013 10:35:34 +0800
Message-ID: <51A6BAF6.4010901@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


When "strlen(s) > MAX_ROOT_LEN", it has already said to use the default
value, but in fact, it still use the input value.

If happens, next sprintf() for 'fname' in simscsi_queuecommand_lck()
may be memory overflow.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/ia64/hp/sim/simscsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/hp/sim/simscsi.c b/arch/ia64/hp/sim/simscsi.c
index 331de72..3a428f1 100644
--- a/arch/ia64/hp/sim/simscsi.c
+++ b/arch/ia64/hp/sim/simscsi.c
@@ -88,8 +88,8 @@ simscsi_setup (char *s)
 	if (strlen(s) > MAX_ROOT_LEN) {
 		printk(KERN_ERR "simscsi_setup: prefix too long---using default %s\n",
 		       simscsi_root);
-	}
-	simscsi_root = s;
+	} else
+		simscsi_root = s;
 	return 1;
 }
 
-- 
1.7.7.6
