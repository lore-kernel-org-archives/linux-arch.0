From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/10] arch: introduce strict_ioremap
Date: Tue, 21 Jul 2015 15:30:51 +0200
Message-ID: <20150721133051.GB8902@lst.de>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com> <20150720001817.30857.69287.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41966 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbbGUNay (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jul 2015 09:30:54 -0400
Content-Disposition: inline
In-Reply-To: <20150720001817.30857.69287.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, geert@linux-m68k.org, toshi.kani@hp.com, ross.zwisler@linux.intel.com, hch@lst.de, linux-arm-kernel@lists.infradead.org

On Sun, Jul 19, 2015 at 08:18:17PM -0400, Dan Williams wrote:
> In preparation for enabling memremap(), add support for strict mappings.
> strict_ioremap_<type>() returns NULL if the arch does not implement the
> mapping type, rather than falling back silently to ioremap().

Please don't introduce another large number of ioremap variants.

I think we should go straight to the ioremap_flags variant, although
I wonder if we should even bother with ioremap_flags for this use
case, given that we really want memremap-like semantics for anything
that isn't plain ioremap (and maybe ioremap_nocache).

Sorry or being the downer, but I really think we need to clean up this
mess deeply insted of trying to paper over it.
