From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/5] ARM: dts: use #include "..." to include DT in the same
 directory
Date: Mon, 15 May 2017 20:14:45 +0900
Message-ID: <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Omar Sandoval <osandov@osandov.com>, Frank Rowand <frowand.list@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Most of DT files in ARM use #include "..." to make pre-processor
include DT in the same directory, but we have 3 exceptional files
that use #include <...> for that.

They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
path from dtc_cpp_flags.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
 arch/arm/boot/dts/versatile-pb.dts    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
index b2d3466..6be8a1e 100644
--- a/arch/arm/boot/dts/imx6q-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
@@ -41,8 +41,8 @@
 
 /dts-v1/;
 
-#include <imx6q.dtsi>
-#include <imx6qdl-zii-rdu2.dtsi>
+#include "imx6q.dtsi"
+#include "imx6qdl-zii-rdu2.dtsi"
 
 / {
 	model = "ZII RDU2 Board";
diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
index 882b3bd..547a766 100644
--- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
@@ -41,8 +41,8 @@
 
 /dts-v1/;
 
-#include <imx6qp.dtsi>
-#include <imx6qdl-zii-rdu2.dtsi>
+#include "imx6qp.dtsi"
+#include "imx6qdl-zii-rdu2.dtsi"
 
 / {
 	model = "ZII RDU2+ Board";
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 33a8eb2..06e2331 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -1,4 +1,4 @@
-#include <versatile-ab.dts>
+#include "versatile-ab.dts"
 
 / {
 	model = "ARM Versatile PB";
-- 
2.7.4
