From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] csky, h8300, riscv: remove <asm/scatterlist.h>
 leftovers
Date: Thu, 6 Dec 2018 16:00:54 +0100
Message-ID: <20181206150054.GA25702@lst.de>
References: <20181109090008.24150-1-hch@lst.de> <20181109090008.24150-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181109090008.24150-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Looks like generic-y is mostly going away anyway, so I'm going to skip
this to avoid conflicts with the kbuild tree.
