Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48858 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWThB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Apr 2019 15:37:01 -0400
Date: Tue, 23 Apr 2019 21:36:45 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: kill <asm/segment.h> and improve nommu generic uaccess helpers
Message-ID: <20190423193645.GA27933@lst.de>
References: <20190423163809.9962-1-hch@lst.de> <CAK8P3a3D7F07kJAXp9yOh7FqEzL8rZeO5Xo9tGxpXFsibpShgg@mail.gmail.com> <20190423183232.GA26846@lst.de> <CAK8P3a35AD7p6aHS3B2ovZVVBnzEcc-Yt6c1xQHMdWkMY8fV7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a35AD7p6aHS3B2ovZVVBnzEcc-Yt6c1xQHMdWkMY8fV7w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Apr 23, 2019 at 08:41:02PM +0200, Arnd Bergmann wrote:
> > Not sure where else it would fit.  It is in support for the RISC-V
> > nommu port, but that isn't ready for the merge window.
> 
> If RISC-V want it, I don't see a problem with merging those patches
> as preparation through the riscv git tree with my Ack for the asm-generic
> portion.

We don't really need it this merge window and the patch stack is huge,
so anything I can dash out earlier is a plus.

I could offer you to send the asm-generic pull request to Linus if
you're off after you have prepared everything else before leaving.
