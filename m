From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 0/3] ioremap() tidy-up
Date: Fri, 17 Mar 2017 12:46:36 -0500
Message-ID: <20170317172752.6308.91062.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbdCQRrX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Mar 2017 13:47:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org

1) Fix some comments that say "IOMMU" when they mean "MMU".

2) Remove the generic __ioremap() definition, which I think is unused and
confusing.

3) Simplify the comments about ioremap() implementation.  I split this out
in case I went too far and made this controversial.

---

Bjorn Helgaas (3):
      asm-generic/io.h: Fix "IOMMU" typos
      asm-generic/io.h: Remove unused generic __ioremap() definition
      asm-generic/io.h: Simplify ioremap() comments


 include/asm-generic/io.h |   33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)
