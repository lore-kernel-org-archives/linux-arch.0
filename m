From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] arch: consolidate CONFIG_STRICT_DEVM in
 lib/Kconfig.debug
Date: Mon, 23 Nov 2015 09:12:35 +0100
Message-ID: <20151123081235.GA23661@gmail.com>
References: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38536 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbbKWIMk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 03:12:40 -0500
Content-Disposition: inline
In-Reply-To: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-nvdimm@lists.01.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> Let all the archs that implement CONFIG_STRICT_DEVM use a common
> definition in lib/Kconfig.debug.

For the x86 bit:

Acked-by: Ingo Molnar <mingo@kernel.org>

> Note, the 'depends on !SPARC' is due to sparc not implementing
> devmem_is_allowed().

Maybe that should be converted into a helper Kconfig switch for architectures to 
opt in to /dev/mem restrictions?

Thanks,

	Ingo
