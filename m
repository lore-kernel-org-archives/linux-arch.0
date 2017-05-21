From: Christoph Hellwig <hch@lst.de>
Subject: is alpha jensen support dead?
Date: Sun, 21 May 2017 10:58:48 +0200
Message-ID: <20170521085848.GA14559@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43114 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbdEUI6u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 May 2017 04:58:50 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

it seems like the Alpha Jense build (the only one using pci-noop.c)
and thus being a different build than all the later PCI capable
system has been broken since at least:

commit 6aca0503847f6329460b15b3ab2b0e30bb752793
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Tue Feb 2 21:46:33 2016 -0800

    alpha/dma: use common noop dma ops

which switches pci-noop.c to use generic code, but fat fingered a symbol
and didn't wire up the Kconfig.

Is there any value in keeping it alive?  Especially as there probably
isn't any build coverage..

Btw, how well is alpha working these days?  It looks like there hasn't
been any maintainer activity for about two years.
