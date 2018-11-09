Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKISjv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2018 13:39:51 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: scatterlist arch cleanups
Date: Fri,  9 Nov 2018 10:00:06 +0100
Message-ID: <20181109090008.24150-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181109090006.AihDDt454BhD-5Q9ujgvg73t2DtduIM0spn6wvUjFB0@z>

Remove leftovers, and switch the default on enabling SG chaining.
