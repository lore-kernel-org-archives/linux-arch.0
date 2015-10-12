Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42354 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbbJLV6e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Oct 2015 17:58:34 -0400
Date: Mon, 12 Oct 2015 23:58:30 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 13/20] intel-iommu: switch from ioremap_cache to memremap
Message-ID: <20151012215830.GT10641@suse.de>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221646.32203.98367.stgit@dwillia2-desk3.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151009221646.32203.98367.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20151012215830.ZpWHDZ133dqhSXB5G5inO0GdDxqAt40wRUFu56k2P00@z>

Hi Dan,

On Fri, Oct 09, 2015 at 06:16:46PM -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_cache() convert its usage in
> intel-iommu to memremap.  This also eliminates the mishandling of the
> __iomem annotation in the implementation.

I appreciate the change, but in the cover letter you write the API is
only implemented for x86 so far? The VT-d driver is also used on ia64,
will it still work there with this patch?


	Joerg

