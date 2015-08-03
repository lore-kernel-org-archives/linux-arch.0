From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 04/24] intel_iommu: fix leaked ioremap mapping
Date: Mon, 3 Aug 2015 16:26:14 +0200
Message-ID: <20150803142537.GY27614@suse.de>
References: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150730165401.33962.81348.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53662 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbbHCO0V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Aug 2015 10:26:21 -0400
Content-Disposition: inline
In-Reply-To: <20150730165401.33962.81348.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, toshi.kani@hp.com, linux-nvdimm@lists.01.org, mcgrof@suse.com, linux-kernel@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org

On Thu, Jul 30, 2015 at 12:54:01PM -0400, Dan Williams wrote:
> iommu_load_old_irte() appears to leak the old_irte mapping after use.
> 
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/iommu/intel_irq_remapping.c |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
