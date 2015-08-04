From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v3 24/24] pmem: convert to generic memremap
Date: Tue, 04 Aug 2015 10:53:40 -0600
Message-ID: <1438707220.12666.7.camel@linux.intel.com>
References: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <20150730165553.33962.20257.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <1438622487.9404.2.camel@linux.intel.com>
	 <CAPcyv4gCPyXwwgjidaUaNyNe8ZitmwVa-NF7pBT-y3rV4XBUzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48521 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbbHDQxo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Aug 2015 12:53:44 -0400
In-Reply-To: <CAPcyv4gCPyXwwgjidaUaNyNe8ZitmwVa-NF7pBT-y3rV4XBUzA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Kani, Toshimitsu" <toshi.kani@hp.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Luis Rodriguez <mcgrof@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 2015-08-03 at 11:01 -0700, Dan Williams wrote:
> On Mon, Aug 3, 2015 at 10:21 AM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > On Thu, 2015-07-30 at 12:55 -0400, Dan Williams wrote:
> >> Update memremap_pmem() to query the architecture for the mapping type of
> >> the given persistent memory range  and then pass those flags to generic
> >> memremap().  arch_memremap_pmem_flags() is provided an address range to
> >> evaluate in the event an arch has a need for different mapping types by
> >> address range.  For example the ACPI NFIT carries EFI mapping types in
> >> its memory range description table.
> >>
> >> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
