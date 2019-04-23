Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48543 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDWScs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Apr 2019 14:32:48 -0400
Date: Tue, 23 Apr 2019 20:32:32 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: kill <asm/segment.h> and improve nommu generic uaccess helpers
Message-ID: <20190423183232.GA26846@lst.de>
References: <20190423163809.9962-1-hch@lst.de> <CAK8P3a3D7F07kJAXp9yOh7FqEzL8rZeO5Xo9tGxpXFsibpShgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3D7F07kJAXp9yOh7FqEzL8rZeO5Xo9tGxpXFsibpShgg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Apr 23, 2019 at 08:27:29PM +0200, Arnd Bergmann wrote:
> Should I pick this up into my asm-generic tree, or do you have another tree
> that this fits into? I might be on vacation during the entire merge window
> this time and don't have anything else for asm-generic, so I'd prefer if someone
> else could merge them.

Not sure where else it would fit.  It is in support for the RISC-V
nommu port, but that isn't ready for the merge window.
