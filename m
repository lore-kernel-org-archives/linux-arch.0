From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [RFC PATCH 0/2] dtc: enable use of pre-processor
Date: Fri, 28 Sep 2012 13:32:09 -0600
Message-ID: <1348860731-20868-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Jon Loeliger <jdl-CYoMK+44s/E@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This series adds some build rules to run cpp on *.dtsp prior to
invoking dtc, and converts Tegra to the new rule as an example. What do
people think?

I assume that you've applied the dtc patches I sent yesterday. They
aren't in this series. See:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020182.html
https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020183.html
https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020181.html
https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020387.html

Note: those patches are against upstream dtc. If you wish to test this
series, apply the dtc patches to upstream dtc, build it, and copy the
resultant dtc binary over the top of scripts/dtc/dtc.

I'll post a patch to update the in-kernel dtc to the upstream dtc as
soon as one final dtc patch has been applied, and this series will then
depend on that patch.

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
