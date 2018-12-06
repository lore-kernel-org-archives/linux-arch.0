Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57689 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLFPAz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Dec 2018 10:00:55 -0500
Date: Thu, 6 Dec 2018 16:00:54 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] csky, h8300, riscv: remove <asm/scatterlist.h>
 leftovers
Message-ID: <20181206150054.GA25702@lst.de>
References: <20181109090008.24150-1-hch@lst.de> <20181109090008.24150-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109090008.24150-2-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181206150054.-Vyd_cD5iLsy7uXK8sjPG6vrmlAdxEnQknjZppuWywI@z>

Looks like generic-y is mostly going away anyway, so I'm going to skip
this to avoid conflicts with the kbuild tree.
