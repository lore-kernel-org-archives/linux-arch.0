From: Nick Hu <nickhu@andestech.com>
Subject: [PATCH v4 4/4] nds32: Add document for NDS32 PMU.
Date: Thu, 25 Oct 2018 10:24:17 +0800
Message-ID: <fb0115313c7c717b1699ce5f21d6f24df457e1d1.1540430862.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ebiederm@xmission.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, zong@andestech.com, alankao@andestech.com, deanbo422@gmail.com
Cc: Nickhu <nickhu@andestech.com>, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Nickhu <nickhu@andestech.com>

The document for how to add NDS32 PMU
in devicetree.

Signed-off-by: Nickhu <nickhu@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/perf/nds32v3-pmu.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt

diff --git a/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt b/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
new file mode 100644
index 000000000000..1bd15785b4ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
@@ -0,0 +1,17 @@
+* NDS32 Performance Monitor Units
+
+NDS32 core have a PMU for counting cpu and cache events like cache misses.
+The NDS32 PMU representation in the device tree should be done as under:
+
+Required properties:
+
+- compatible :
+	"andestech,nds32v3-pmu"
+
+- interrupts : The interrupt number for NDS32 PMU is 13.
+
+Example:
+pmu{
+	compatible = "andestech,nds32v3-pmu";
+	interrupts = <13>;
+}
-- 
2.17.0
