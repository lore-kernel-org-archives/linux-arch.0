From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 08/25] arch: introduce memremap()
Date: Mon, 27 Jul 2015 07:12:16 +0200
Message-ID: <20150727051216.GA15836@lst.de>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com> <20150725023842.8664.97620.stgit@dwillia2-desk3.amr.corp.intel.com> <20150726172527.GA29513@lst.de> <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35835 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbbG0FMT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Jul 2015 01:12:19 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Kani, Toshimitsu" <toshi.kani@hp.com>, Arnd Bergmann <arnd@arndb.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Jul 26, 2015 at 10:49:39AM -0700, Dan Williams wrote:
> > What's the point of having this MEMREMAP_CACHE alias?
> 
> For developers that are used to seeing ioremap_cache()...

Meh.  We've got git logs that show clearly what replaced a previous API.
Duplicate names for the same API are highly confusing.
