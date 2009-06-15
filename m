From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] new files for score architecture
Date: Mon, 15 Jun 2009 07:46:49 -0400
Message-ID: <20090615114649.GA20531@infradead.org>
References: <20090615112628.GA26150@infradead.org> <OF28F09400.68D4B737-ON482575D6.003FA1F3-482575D6.00403088@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:48320 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZFOLqs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2009 07:46:48 -0400
Content-Disposition: inline
In-Reply-To: <OF28F09400.68D4B737-ON482575D6.003FA1F3-482575D6.00403088@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jun 15, 2009 at 07:36:33PM +0800, liqin.chen@sunplusct.com wrote:
> Thanks your comment, I had removed unused code from ptrace.

Note that it's not simply unused code.  There have been quite a few
changes to the ptrace interface over the last year, including moving
more code into generic helpers.  Take a look at those architectures
defining HAVE_ARCH_TRACEHOOK in their Kconfig for a guide.  Fortunately
it should make the remaining architecture code a lot simpler.

Also http://sourceware.org/systemtap/wiki/utrace/arch/HowTo might
be pretty helpful.
