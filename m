Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGCMYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2019 08:24:01 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: nommu fixups
Date: Wed,  3 Jul 2019 05:23:56 -0700
Message-ID: <20190703122359.18200-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20190703122356.IldeWYXG34DZJItY5kLvaOK0zAgqjsmFGEHaW-aJD9M@z>

Hi Andrew,

the patches are fixups developed for the RISC-V nommu port.  Can you
queue them up in -mm?
