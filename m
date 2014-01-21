From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 28/73] cpuidle: don't use modular platform register in
 non-modular ARM drivers
Date: Tue, 21 Jan 2014 16:22:31 -0500
Message-ID: <1390339396-3479-29-git-send-email-paul.gortmaker@windriver.com>
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
Cc: linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

These two drivers are configured with Kconfig options that are
both declared as bool.  Hence it is not possible for the code
to be built as modular.  However the code is currently using the
module_platform_driver() macro for driver registration.

While this currently works, we really don't want to be including
the module.h header in non-modular code, which we'll be forced
to do, pending some upcoming code relocation from init.h into
module.h.  So we fix it now by using the non-modular equivalent.

With some macro detangulation, and a little help from cpp, we can
see that module_platform_driver(calxeda_cpuidle_plat_driver) gets
roughly translated into:

  static int __init calxeda_cpuidle_plat_driver_init(void)
  {
        return platform_driver_register(&calxeda_cpuidle_plat_driver);
  }
  module_init(calxeda_cpuidle_plat_driver_init);

  static void __exit calxeda_cpuidle_plat_driver_exit(void)
  {
        platform_driver_unregister(&calxeda_cpuidle_plat_driver);
  }
  module_exit(calxeda_cpuidle_plat_driver_exit);

[and similarly for the other file, cpuidle-zynq.c]

And since we've already established that the code is non-modular,
we can completely drop any code relating to module_exit.  For non
modular code, module_init beomes __initcall.  But direct use of
__initcall is discouraged, vs. one of the priority categorized
subgroups.  As __initcall gets mapped onto device_initcall, our
use of device_initcall directly in this change means that the
runtime impact is zero -- they will remain at level 6 in the
initcall ordering.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/cpuidle/cpuidle-calxeda.c | 6 +++++-
 drivers/cpuidle/cpuidle-zynq.c    | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index 6e51114..631e2cd 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -78,4 +78,8 @@ static struct platform_driver calxeda_cpuidle_plat_driver = {
         .probe = calxeda_cpuidle_probe,
 };
 
-module_platform_driver(calxeda_cpuidle_plat_driver);
+static int __init calxeda_cpuidle_plat_driver_init(void)
+{
+	return platform_driver_register(&calxeda_cpuidle_plat_driver);
+}
+device_initcall(calxeda_cpuidle_plat_driver_init);
diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index aded759..a1aae51 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -85,4 +85,8 @@ static struct platform_driver zynq_cpuidle_driver = {
 	.probe = zynq_cpuidle_probe,
 };
 
-module_platform_driver(zynq_cpuidle_driver);
+static int __init zynq_cpuidle_driver_init(void)
+{
+	return platform_driver_register(&zynq_cpuidle_driver);
+}
+device_initcall(zynq_cpuidle_driver_init);
-- 
1.8.4.1
