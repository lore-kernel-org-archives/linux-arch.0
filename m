Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfDWQig (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 12:38:36 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: kill <asm/segment.h> and improve nommu generic uaccess helpers
Date: Tue, 23 Apr 2019 18:38:05 +0200
Message-Id: <20190423163809.9962-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Hi Arnd,

this is a series doing two somewhat interwinded things.  It improves
the asm-generic nommu uaccess helper to optionally be entirely generic
and not require any arch helpers for the actual uaccess.  For the
generic uaccess.h to actually be generically useful I also had to kill
off the mess we made of <asm/segment.h>, which really shouldn't exist
on most architectures.
