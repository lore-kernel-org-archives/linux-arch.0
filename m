From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V3 0/2] dtc: enable use of pre-processor
Date: Mon,  1 Oct 2012 09:45:49 -0600
Message-ID: <1349106351-17714-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: linux-kbuild@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>, Jon Loeliger <jdl@jdl.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Scott Wood <scottwood@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-arch.vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

This series adds a build rule to run cpp on *.dtsp prior to invoking dtc.

This patch relies on the patch I recently posted to update the in-kernel
copy of dtc to match the latest upstream version ("[PATCH] dtc: import
latest upstream dtc"; http://www.spinics.net/lists/kernel/msg1410063.html.

Stephen Warren (2):
  kbuild: centralize .dts->.dtb rule
  kbuild: introduce cmd_dtc_cpp

 arch/arm/boot/Makefile           |    4 ----
 arch/arm/boot/dts/skeleton.dtsip |   13 +++++++++++++
 arch/c6x/boot/Makefile           |    3 ---
 arch/openrisc/boot/Makefile      |    3 ---
 arch/powerpc/boot/Makefile       |    4 ----
 scripts/Makefile.lib             |    9 +++++++++
 6 files changed, 22 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/boot/dts/skeleton.dtsip
