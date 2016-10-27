From: ville.syrjala@linux.intel.com
Subject: [PATCH] intel_idle: Don't use on Lenovo Ideapad S10-3t
Date: Thu, 27 Oct 2016 21:10:14 +0300
Message-ID: <1477591814-10985-1-git-send-email-ville.syrjala@linux.intel.com>
References: <1446499360-31984-1-git-send-email-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446499360-31984-1-git-send-email-ville.syrjala@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: feng.tang@intel.com, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Lenovo Ideapad S10-3t hangs coming out of S3 with intel_idle.
The two workaround that seem to help are "intel_idle.max_cstate=0"
or "nohz=off highres=off".

At a first glance quirk_tigerpoint_bm_sts() seemed promising, but
even when moved to early_resume it didn't do anything.

I have no idea what's wrong here, so let's just disable intel_idle
for these machines using a DMI match.

I sent this patch originally about one year ago, at which time I was
asked to file a bug, which I did [1], which was mostly a waste of time
since no one actually did anything to fix the problem. In the
meantime even acpi-idle got broken and then fixed again [2], so at
least there's still a working alternative. As intel_idle has never
worked on this machine, and it looks like no one has any real
intention to fix it, I'm going to suggest *again* that we simply
disable intel_idle on this machine and get on with life.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=107151
[2] https://lkml.org/lkml/2016/5/11/238

Cc: feng.tang@intel.com
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/idle/intel_idle.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 4466a2f969d7..db81b27f6250 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -59,6 +59,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/dmi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
@@ -1089,6 +1090,25 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	{}
 };
 
+static int intel_idle_disable_callback(const struct dmi_system_id *id)
+{
+	pr_debug(PREFIX "problematic system (%s), disabling\n", id->ident);
+	return 1;
+}
+
+static const struct dmi_system_id intel_idle_disable_dmi[] = {
+	{
+		/* Lenovo Ideapad S10-3t, hangs coming out of S3 */
+		.callback = intel_idle_disable_callback,
+		.ident = "Lenovo Ideapad S10-3t",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Ideapad S10-3t"),
+		},
+	},
+	{}
+};
+
 /*
  * intel_idle_probe()
  */
@@ -1121,6 +1141,9 @@ static int __init intel_idle_probe(void)
 	    !mwait_substates)
 			return -ENODEV;
 
+	if (dmi_check_system(intel_idle_disable_dmi))
+		return -ENODEV;
+
 	pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
 
 	icpu = (const struct idle_cpu *)id->driver_data;
-- 
2.7.4
