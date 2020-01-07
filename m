Return-Path: <SRS0=n+LR=24=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgAGQxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jan 2020 11:53:30 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Date: Tue,  7 Jan 2020 17:52:57 +0100
Message-Id: <1578415992-24054-1-git-send-email-krzk@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Hi,

The ioread8/16/32() and others have inconsistent interface among the
architectures: some taking address as const, some not.

It seems there is nothing really stopping all of them to take
pointer to const.

Patchset was really tested on all affected architectures.
Build testing is in progress - I hope auto-builders will point any issues.


Todo
====
Convert also string versions (ioread16_rep() etc) if this aproach looks OK.


Merging
=======
The first 5 patches - iomap, alpha, sh, parisc and powerpc - should probably go
via one tree, or even squashed into one.

All other can go separately after these get merged.

Best regards,
Krzysztof


Krzysztof Kozlowski (13):
  iomap: Constify ioreadX() iomem argument (as in generic
    implementation)
  alpha: Constify ioreadX() iomem argument (as in generic
    implementation)
  sh: Constify ioreadX() iomem argument (as in generic implementation)
  parisc: Constify ioreadX() iomem argument (as in generic
    implementation)
  powerpc: Constify ioreadX() iomem argument (as in generic
    implementation)
  arc: Constify ioreadX() iomem argument (as in generic implementation)
  drm/mgag200: Constify ioreadX() iomem argument (as in generic
    implementation)
  drm/nouveau: Constify ioreadX() iomem argument (as in generic
    implementation)
  media: fsl-viu: Constify ioreadX() iomem argument (as in generic
    implementation)
  net: wireless: ath5k: Constify ioreadX() iomem argument (as in generic
    implementation)
  net: wireless: rtl818x: Constify ioreadX() iomem argument (as in
    generic implementation)
  ntb: intel: Constify ioreadX() iomem argument (as in generic
    implementation)
  virtio: pci: Constify ioreadX() iomem argument (as in generic
    implementation)

 arch/alpha/include/asm/core_apecs.h                |  6 +--
 arch/alpha/include/asm/core_cia.h                  |  6 +--
 arch/alpha/include/asm/core_lca.h                  |  6 +--
 arch/alpha/include/asm/core_marvel.h               |  4 +-
 arch/alpha/include/asm/core_mcpcia.h               |  6 +--
 arch/alpha/include/asm/core_t2.h                   |  2 +-
 arch/alpha/include/asm/io.h                        | 12 +++---
 arch/alpha/include/asm/io_trivial.h                | 16 ++++----
 arch/alpha/include/asm/jensen.h                    |  2 +-
 arch/alpha/include/asm/machvec.h                   |  6 +--
 arch/alpha/kernel/core_marvel.c                    |  2 +-
 arch/alpha/kernel/io.c                             |  6 +--
 arch/arc/plat-axs10x/axs10x.c                      |  4 +-
 arch/parisc/include/asm/io.h                       |  4 +-
 arch/parisc/lib/iomap.c                            | 48 +++++++++++-----------
 arch/powerpc/kernel/iomap.c                        | 22 +++++-----
 arch/sh/kernel/iomap.c                             | 10 ++---
 drivers/gpu/drm/mgag200/mgag200_drv.h              |  4 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  2 +-
 drivers/media/platform/fsl-viu.c                   |  2 +-
 drivers/net/wireless/ath/ath5k/ahb.c               | 10 ++---
 .../net/wireless/realtek/rtl818x/rtl8180/rtl8180.h |  6 +--
 drivers/ntb/hw/intel/ntb_hw_gen1.c                 |  2 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.h                 |  2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h                |  2 +-
 drivers/virtio/virtio_pci_modern.c                 |  6 +--
 include/asm-generic/iomap.h                        | 22 +++++-----
 include/linux/io-64-nonatomic-hi-lo.h              |  4 +-
 include/linux/io-64-nonatomic-lo-hi.h              |  4 +-
 lib/iomap.c                                        | 18 ++++----
 30 files changed, 123 insertions(+), 123 deletions(-)

-- 
2.7.4
