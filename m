From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/5] devicetree: cleanup and improve DT cross-arch reference
Date: Mon, 15 May 2017 20:14:43 +0900
Message-ID: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kbuild@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Olof Johansson <olof@lixom.net>, Michal Marek <mmarek@suse.com>, Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Grant Likely <grant.likely@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Omar Sandoval <osandov@osandov.com>, Frank Rowand <frowand.list@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This series depends on Olof's
"devicetree: Move include prefixes from arch to separate directory"
https://patchwork.kernel.org/patch/9724995/

1/5: clean-up of unused include path
2/5: Fixup of last three DT files in ARM (needed for 4/5)
3/5: Fixup of last three DT files in PowerPC (needed for 4/5)
4/5: Remove arch/$(SRCARCH)/boot/dts include path
5/5: Make DT cross-arch reference available for /include/ directive


Masahiro Yamada (5):
  of: remove drivers/of/testcase-data from include search path for CPP
  ARM: dts: use #include "..." to include DT in the same directory
  powerpc: dts: use #include "..." to include DT in the same directory
  of: remove arch/$(SRCARCH)/boot/dts from include search path for CPP
  of: add scripts/dtc/include-prefixes to search path for both CPP and
    DTC

 arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
 arch/arm/boot/dts/versatile-pb.dts    | 2 +-
 arch/powerpc/boot/dts/ac14xx.dts      | 2 +-
 arch/powerpc/boot/dts/mpc5121ads.dts  | 2 +-
 arch/powerpc/boot/dts/pdm360ng.dts    | 2 +-
 scripts/Makefile.lib                  | 8 ++++----
 7 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.7.4
