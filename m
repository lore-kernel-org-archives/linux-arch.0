From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v2 22/25] pmem: switch from ioremap_wt to memremap
Date: Wed, 29 Jul 2015 13:12:36 -0600
Message-ID: <1438197156.17072.0.camel@linux.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <20150725024001.8664.13362.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31971 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG2TMh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Jul 2015 15:12:37 -0400
In-Reply-To: <20150725024001.8664.13362.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, toshi.kani@hp.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk, hch@lst.de, linux-arm-kernel@lists.infradead.org

On Fri, 2015-07-24 at 22:40 -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_wt() convert its usage in
> the PMEM API to memremap.
> 
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ross Zwisler <ross.zwisler@linux.intel.com>
