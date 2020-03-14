From: Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 03/10] arm64: hyperv: Add hypercall and register access
 functions
Date: Sat, 14 Mar 2020 08:35:12 -0700
Message-ID: <1584200119-18594-4-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: will@kernel.org, ardb@kernel.org, arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com
Cc: sunilmut@microsoft.com, boqun.feng@gmail.com, mikelley@microsoft.com
List-Id: linux-arch.vger.kernel.org

Add ARM64-specific code to make Hyper-V hypercalls and to
access virtual processor synthetic registers via hypercalls.
Hypercalls follow the SMC Calling Convention spec v1.1.

This code is architecture dependent and is mostly driven by
architecture independent code in the VMbus driver and the
Hyper-V timer clocksource driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 MAINTAINERS                 |   1 +
 arch/arm64/Kbuild           |   1 +
 arch/arm64/hyperv/Makefile  |   2 +
 arch/arm64/hyperv/hv_core.c | 167 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 398cfdb..64ad2bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7811,6 +7811,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
 F:	arch/arm64/include/asm/hyperv-tlfs.h
 F:	arch/arm64/include/asm/mshyperv.h
+F:	arch/arm64/hyperv
 F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index d646582..7a37608 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -3,4 +3,5 @@ obj-y			+= kernel/ mm/
 obj-$(CONFIG_NET)	+= net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
+obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
 obj-$(CONFIG_CRYPTO)	+= crypto/
diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
new file mode 100644
index 0000000..1697d30
--- /dev/null
+++ b/arch/arm64/hyperv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		:= hv_core.o
diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
new file mode 100644
index 0000000..272c348
--- /dev/null
+++ b/arch/arm64/hyperv/hv_core.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Initialization of the interface with Microsoft's Hyper-V hypervisor,
+ * and various low level utility routines for interacting with Hyper-V.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/hyperv.h>
+#include <linux/arm-smccc.h>
+#include <asm-generic/bug.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+
+/*
+ * hv_do_hypercall- Invoke the specified hypercall
+ */
+u64 hv_do_hypercall(u64 control, void *input, void *output)
+{
+	u64 input_address;
+	u64 output_address;
+	struct arm_smccc_res res;
+
+	input_address = input ? virt_to_phys(input) : 0;
+	output_address = output ? virt_to_phys(output) : 0;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
+			  input_address, output_address, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_hypercall);
+
+/*
+ * hv_do_fast_hypercall8 -- Invoke the specified hypercall
+ * with arguments in registers instead of physical memory.
+ * Avoids the overhead of virt_to_phys for simple hypercalls.
+ */
+
+u64 hv_do_fast_hypercall8(u16 code, u64 input)
+{
+	u64 control;
+	struct arm_smccc_res res;
+
+	control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
+
+
+/*
+ * Set a single VP register to a 64-bit value.
+ */
+void hv_set_vpreg(u32 msr, u64 value)
+{
+	union hv_hypercall_status status;
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(
+		HV_FUNC_ID,
+		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		0,
+		value,
+		0,
+		&res);
+	status.as_uint64 = res.a0;
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * setting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status != HV_STATUS_SUCCESS);
+}
+EXPORT_SYMBOL_GPL(hv_set_vpreg);
+
+/*
+ * Get the value of a single VP register.  One version
+ * returns just 64 bits and another returns the full 128 bits.
+ * The two versions are separate to avoid complicating the
+ * calling sequence for the more frequently used 64 bit version.
+ */
+
+/*
+ * Input and output memory allocation sizes are rounded up to a power
+ * of 2 so kmalloc() will guarantee alignment. In turn, the alignment
+ * ensures that the allocations don't cross a page boundary, which is
+ * required by the hypercall interface.
+ */
+#define INPUTSIZE (4 * sizeof(u64))
+#define OUTPUTSIZE (2 * sizeof(u64))
+
+static void __hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *res)
+{
+	union hv_hypercall_status		status;
+	struct hv_get_vp_register_input		*input;
+
+	BUILD_BUG_ON(sizeof(*input) > INPUTSIZE);
+
+	input = kzalloc(INPUTSIZE, GFP_ATOMIC);
+
+	input->partitionid = HV_PARTITION_ID_SELF;
+	input->vpindex = HV_VP_INDEX_SELF;
+	input->inputvtl = 0;
+	input->name0 = msr;
+	input->name1 = 0;
+
+
+	status.as_uint64 = hv_do_hypercall(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COUNT_1,
+		input, res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status != HV_STATUS_SUCCESS);
+
+	kfree(input);
+}
+
+u64 hv_get_vpreg(u32 msr)
+{
+	struct hv_get_vp_register_output	*output;
+	u64					result;
+
+	BUILD_BUG_ON(sizeof(*output) > OUTPUTSIZE);
+	output = kmalloc(OUTPUTSIZE, GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, output);
+
+	result = output->registervaluelow;
+	kfree(output);
+	return result;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *res)
+{
+	struct hv_get_vp_register_output	*output;
+
+	BUILD_BUG_ON(sizeof(*output) > OUTPUTSIZE);
+	output = kmalloc(OUTPUTSIZE, GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, output);
+
+	res->registervaluelow = output->registervaluelow;
+	res->registervaluehigh = output->registervaluehigh;
+	kfree(output);
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
-- 
1.8.3.1
