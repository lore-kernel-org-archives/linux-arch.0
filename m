From: Matthias Maennich <maennich-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 00/11] Symbol Namespaces
Date: Wed, 21 Aug 2019 12:49:15 +0100
Message-ID: <20190821114955.12788-1-maennich@google.com>
References: <20190813121733.52480-1-maennich@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190813121733.52480-1-maennich-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, oneukum-IBi9RG/b67k@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-aspeed-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, usb-storage-ijkIwGHArpdIPJnuZ7Njw4oP9KaGy4wf@public.gmane.org, Toru Komatsu <k0ma-h7Lmzv2voGl4Eiagz67IpQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, patches-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, joel-QYYGw3jwrUn5owFQY34kdNi2O/JbrIOy@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Fair <benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Nancy Yuen <yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Johannes
List-Id: linux-arch.vger.kernel.org

As of Linux 5.3-rc5, there are 31205 [1] exported symbols in the kernel.
That is a growth of roughly 1000 symbols since 4.17 (30206 [2]).  There
seems to be some consensus amongst kernel devs that the export surface
is too large, and hard to reason about.

Generally, these symbols fall in one of these categories:
1) Symbols actually meant for drivers
2) Symbols that are only exported because functionality is split over
   multiple modules, yet they really shouldn't be used by modules outside
   of their own subsystem
3) Symbols really only meant for in-tree use

When module developers try to upstream their code, it regularly turns
out that they are using exported symbols that they really shouldn't be
using. This problem is even bigger for drivers that are currently
out-of-tree, which may be using many symbols that they shouldn't be
using, and that break when those symbols are removed or modified.

This patch allows subsystem maintainers to partition their exported
symbols into separate namespaces, and module authors to import such
namespaces only when needed.

This allows subsystem maintainers to more easily limit availability of
these namespaced symbols to other parts of the kernel. It can also be
used to partition the set of exported symbols for documentation
purposes; for example, a set of symbols that is really only used for
debugging could be in a "SUBSYSTEM_DEBUG" namespace.

I continued the work mainly done by Martijn Coenen.

Changes in v2:
- Rather than adding and evaluating separate sections __knsimport_NS,
  use modinfo tags to declare the namespaces a module introduces.
  Adjust modpost and the module loader accordingly.
- Also add support for reading multiple modinfo values for the same tag
  to allow list-like access to modinfo tags.
- The macros in export.h have been cleaned up to avoid redundancy in the
  macro parameters (ns, nspost, nspost2).
- The introduction of relative references in the ksymtab entries caused
  a rework of the macros to accommodate that configuration as well.
- Alignment of kernel_symbol in the ksymtab needed to be fixed to allow
  growing the kernel_symbol struct.
- Modpost does now also append the namespace suffix to the symbol
  entries in Module.symvers.
- The configuration option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS allows
  relaxing the enforcement of properly declared namespace imports at
  module loading time.
- Symbols can be collectively exported into a namespace by defining
  DEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile.
- The requirement for a very recent coccinelle spatch has been lifted by
  simplifying the script.
- nsdeps does now ensures MODULE_IMPORT_NS statements are sorted when
  patching the module source files.
- Some minor bugs have been addressed in nsdeps to allow it to work with
  modules that have more than one source file.
- The RFC for the usb-storage symbols has been simplified by using
  DEFAULT_SYMBOL_NAMESPACE=USB_STORAGE rather than explicitly exporting
  each and every symbol into that new namespace.

Changes in v3:
- Reword the documentation for the
  MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS option for clarification.
- Fix printed required version of spatch in coccinelle script.
- Adopt kbuild changes for modpost: .mod files are no longer generated
  in .tmp_versions. Similarely, generate the .ns_deps files in the tree
  along with the .mod files. Also, nsdeps now uses modules.order as
  source for the list modules to consider.
- Add an RFC patch to introduce the namespace WATCHDOG_CORE for symbols
  exported in watchdog_core.c.

This patch series was developed against Linus' master (15d90b242290).

[1] git grep "^EXPORT_SYMBOL\w*(" v5.3-rc5 | wc -l
[2] git grep "^EXPORT_SYMBOL\w*(" v4.17    | wc -l


Matthias Maennich (11):
  module: support reading multiple values per modinfo tag
  export: explicitly align struct kernel_symbol
  module: add support for symbol namespaces.
  modpost: add support for symbol namespaces
  module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
  export: allow definition default namespaces in Makefiles or sources
  modpost: add support for generating namespace dependencies
  scripts: Coccinelle script for namespace dependencies.
  usb-storage: remove single-use define for debugging
  RFC: usb-storage: export symbols in USB_STORAGE namespace
  RFC: watchdog: export core symbols in WATCHDOG_CORE namespace

 .gitignore                                  |   1 +
 MAINTAINERS                                 |   5 +
 Makefile                                    |  14 +-
 arch/m68k/include/asm/export.h              |   1 -
 drivers/hwmon/ftsteutates.c                 |   1 +
 drivers/hwmon/sch56xx-common.c              |   1 +
 drivers/rtc/rtc-abx80x.c                    |   1 +
 drivers/usb/storage/Makefile                |   2 +
 drivers/usb/storage/alauda.c                |   1 +
 drivers/usb/storage/cypress_atacb.c         |   1 +
 drivers/usb/storage/datafab.c               |   1 +
 drivers/usb/storage/debug.h                 |   2 -
 drivers/usb/storage/ene_ub6250.c            |   1 +
 drivers/usb/storage/freecom.c               |   1 +
 drivers/usb/storage/isd200.c                |   1 +
 drivers/usb/storage/jumpshot.c              |   1 +
 drivers/usb/storage/karma.c                 |   1 +
 drivers/usb/storage/onetouch.c              |   1 +
 drivers/usb/storage/realtek_cr.c            |   1 +
 drivers/usb/storage/scsiglue.c              |   2 +-
 drivers/usb/storage/sddr09.c                |   1 +
 drivers/usb/storage/sddr55.c                |   1 +
 drivers/usb/storage/shuttle_usbat.c         |   1 +
 drivers/usb/storage/uas.c                   |   1 +
 drivers/watchdog/armada_37xx_wdt.c          |   1 +
 drivers/watchdog/asm9260_wdt.c              |   1 +
 drivers/watchdog/aspeed_wdt.c               |   1 +
 drivers/watchdog/at91sam9_wdt.c             |   1 +
 drivers/watchdog/atlas7_wdt.c               |   1 +
 drivers/watchdog/bcm2835_wdt.c              |   1 +
 drivers/watchdog/bcm47xx_wdt.c              |   1 +
 drivers/watchdog/bcm7038_wdt.c              |   1 +
 drivers/watchdog/bcm_kona_wdt.c             |   1 +
 drivers/watchdog/bd70528_wdt.c              |   1 +
 drivers/watchdog/cadence_wdt.c              |   1 +
 drivers/watchdog/da9052_wdt.c               |   1 +
 drivers/watchdog/da9055_wdt.c               |   1 +
 drivers/watchdog/da9062_wdt.c               |   1 +
 drivers/watchdog/da9063_wdt.c               |   1 +
 drivers/watchdog/davinci_wdt.c              |   1 +
 drivers/watchdog/digicolor_wdt.c            |   1 +
 drivers/watchdog/dw_wdt.c                   |   1 +
 drivers/watchdog/ebc-c384_wdt.c             |   1 +
 drivers/watchdog/ep93xx_wdt.c               |   1 +
 drivers/watchdog/ftwdt010_wdt.c             |   1 +
 drivers/watchdog/gpio_wdt.c                 |   1 +
 drivers/watchdog/hpwdt.c                    |   1 +
 drivers/watchdog/i6300esb.c                 |   1 +
 drivers/watchdog/iTCO_wdt.c                 |   1 +
 drivers/watchdog/ie6xx_wdt.c                |   1 +
 drivers/watchdog/imgpdc_wdt.c               |   1 +
 drivers/watchdog/imx2_wdt.c                 |   1 +
 drivers/watchdog/intel-mid_wdt.c            |   1 +
 drivers/watchdog/it87_wdt.c                 |   1 +
 drivers/watchdog/kempld_wdt.c               |   1 +
 drivers/watchdog/lpc18xx_wdt.c              |   1 +
 drivers/watchdog/max63xx_wdt.c              |   1 +
 drivers/watchdog/max77620_wdt.c             |   1 +
 drivers/watchdog/mei_wdt.c                  |   1 +
 drivers/watchdog/mena21_wdt.c               |   1 +
 drivers/watchdog/menf21bmc_wdt.c            |   1 +
 drivers/watchdog/menz69_wdt.c               |   1 +
 drivers/watchdog/meson_gxbb_wdt.c           |   1 +
 drivers/watchdog/meson_wdt.c                |   1 +
 drivers/watchdog/mlx_wdt.c                  |   1 +
 drivers/watchdog/moxart_wdt.c               |   1 +
 drivers/watchdog/mtk_wdt.c                  |   1 +
 drivers/watchdog/ni903x_wdt.c               |   1 +
 drivers/watchdog/nic7018_wdt.c              |   1 +
 drivers/watchdog/npcm_wdt.c                 |   1 +
 drivers/watchdog/of_xilinx_wdt.c            |   1 +
 drivers/watchdog/omap_wdt.c                 |   1 +
 drivers/watchdog/pm8916_wdt.c               |   1 +
 drivers/watchdog/qcom-wdt.c                 |   1 +
 drivers/watchdog/rave-sp-wdt.c              |   1 +
 drivers/watchdog/renesas_wdt.c              |   1 +
 drivers/watchdog/retu_wdt.c                 |   1 +
 drivers/watchdog/rn5t618_wdt.c              |   1 +
 drivers/watchdog/rza_wdt.c                  |   1 +
 drivers/watchdog/s3c2410_wdt.c              |   1 +
 drivers/watchdog/sama5d4_wdt.c              |   1 +
 drivers/watchdog/sirfsoc_wdt.c              |   1 +
 drivers/watchdog/softdog.c                  |   1 +
 drivers/watchdog/sp5100_tco.c               |   1 +
 drivers/watchdog/sprd_wdt.c                 |   1 +
 drivers/watchdog/st_lpc_wdt.c               |   1 +
 drivers/watchdog/stmp3xxx_rtc_wdt.c         |   1 +
 drivers/watchdog/stpmic1_wdt.c              |   1 +
 drivers/watchdog/sunxi_wdt.c                |   1 +
 drivers/watchdog/tangox_wdt.c               |   1 +
 drivers/watchdog/tegra_wdt.c                |   1 +
 drivers/watchdog/tqmx86_wdt.c               |   1 +
 drivers/watchdog/ts4800_wdt.c               |   1 +
 drivers/watchdog/ts72xx_wdt.c               |   1 +
 drivers/watchdog/twl4030_wdt.c              |   1 +
 drivers/watchdog/uniphier_wdt.c             |   1 +
 drivers/watchdog/via_wdt.c                  |   1 +
 drivers/watchdog/w83627hf_wdt.c             |   1 +
 drivers/watchdog/watchdog_core.c            |  10 +-
 drivers/watchdog/wdat_wdt.c                 |   1 +
 drivers/watchdog/wm831x_wdt.c               |   1 +
 drivers/watchdog/wm8350_wdt.c               |   1 +
 drivers/watchdog/xen_wdt.c                  |   1 +
 drivers/watchdog/ziirave_wdt.c              |   1 +
 include/asm-generic/export.h                |  14 +-
 include/linux/export.h                      |  92 +++++++++++--
 include/linux/module.h                      |   2 +
 init/Kconfig                                |  13 ++
 kernel/module.c                             |  67 +++++++++-
 scripts/Makefile.modpost                    |   4 +-
 scripts/coccinelle/misc/add_namespace.cocci |  23 ++++
 scripts/mod/modpost.c                       | 137 ++++++++++++++++++--
 scripts/mod/modpost.h                       |   9 ++
 scripts/nsdeps                              |  56 ++++++++
 114 files changed, 504 insertions(+), 46 deletions(-)
 create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
 create mode 100644 scripts/nsdeps

-- 
2.23.0.rc1.153.gdeed80330f-goog
