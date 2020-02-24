Return-Path: <SRS0=as/e=4M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgBXTpM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 14:45:12 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: provide in-place uncached remapping for dma-direct v2
Date: Mon, 24 Feb 2020 11:44:40 -0800
Message-ID: <20200224194446.690816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200224194440.v0aZj-pyPeFF6Cwk6i6Nx5ULkxUSf_Y1bmbV5rWf3C4@z>

Hi all,

this series provides support for remapping places uncached in-place in
the generic dma-direct code, and moves openrisc over from its own
in-place remapping scheme.  The arm64 folks also had interest in such
a scheme to avoid problems with speculating into cache aliases.

Also all architectures that always use small page mappings for the
kernel and have non-coherent DMA should look into enabling this
scheme, as it is much more efficient than the vmap remapping.

Changes since v1:
 - share the arch hook for inline remap and uncached segment support
