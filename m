Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43574 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbbBWV7A (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Feb 2015 16:59:00 -0500
Date: Mon, 23 Feb 2015 13:58:47 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: fs: dax: do not build on ARC or SH
Message-ID: <20150223215847.GA29052@infradead.org>
References: <5778538.KJ98x3yxkB@wuerfel>
 <20150223184025.GD2780@wil.cx>
 <20150223215634.GA23928@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150223215634.GA23928@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matthew Wilcox <willy@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Message-ID: <20150223215847.LNY-0KzEzsGSNqetB6Jmz6yMZiNaWy6GKZqYhFp8fec@z>

On Mon, Feb 23, 2015 at 01:56:34PM -0800, Guenter Roeck wrote:
> Guess there a philosophical difference in opinion if the architecture code
> should (have to) provide copy_user_page() or not outside the architecture
> code itself. After all, fs/dax.c _is_ the only user of this function outside
> the architecture code.

Given that copy_user_page just is an optimized version of copy_page
all these architectures should just grab the trivial macro defintion
from the asm-generic version so that we could avoid this discussion.
