Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932144AbdCTSms (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 14:42:48 -0400
Subject: [PATCH v2 0/4] ioremap() tidy-up
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 Mar 2017 13:42:39 -0500
Message-ID: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20170320184239.Z-wEgv0_PPVTJXgobmeoh91d0WV2am0Pf7TNhi3j-Bs@z>

Fix some typos, remove unused code, simplify comments.

I added patch 4 to remove the default ioremap_uc() implementation on MMU
systems.

I hesitated about this because it basically reverts 8c7ea50c010b ("x86/mm,
asm-generic: Add IOMMU ioremap_uc() variant default"), and I'm worried that
I'm missing the real value of having that default implementation.  So this
is just a proposal; if it makes no sense, I'll drop patch 4 again.

As far as I can tell, having the default ioremap_uc() implementation means
we can *build* drivers that use it, but those drivers won't actually work.
It seems preferable to me to have those be build-time failures rather than
run-time failures, but if I'm missing something, let me know.

Change from v1 to v2:
  - Add Arnd's Reviewed-by on patches 1-3.
  - Add patch 4 to remove ioremap_uc() stub.

---

Bjorn Helgaas (4):
      asm-generic/io.h: Fix "IOMMU" typos
      asm-generic/io.h: Remove unused generic __ioremap() definition
      asm-generic/io.h: Simplify ioremap() comments
      asm-generic/io.h: Drop ioremap_uc() stub for systems with MMU


 include/asm-generic/io.h |   49 ++++++++--------------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)
