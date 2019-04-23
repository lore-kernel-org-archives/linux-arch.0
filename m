Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41087 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSlV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 14:41:21 -0400
Received: by mail-lf1-f44.google.com with SMTP id t30so12519764lfd.8
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 11:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190423163809.9962-1-hch@lst.de> <CAK8P3a3D7F07kJAXp9yOh7FqEzL8rZeO5Xo9tGxpXFsibpShgg@mail.gmail.com>
 <20190423183232.GA26846@lst.de>
In-Reply-To: <20190423183232.GA26846@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Apr 2019 20:41:02 +0200
Message-ID: <CAK8P3a35AD7p6aHS3B2ovZVVBnzEcc-Yt6c1xQHMdWkMY8fV7w@mail.gmail.com>
Subject: Re: kill <asm/segment.h> and improve nommu generic uaccess helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Tue, Apr 23, 2019 at 8:32 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Apr 23, 2019 at 08:27:29PM +0200, Arnd Bergmann wrote:
> > Should I pick this up into my asm-generic tree, or do you have another tree
> > that this fits into? I might be on vacation during the entire merge window
> > this time and don't have anything else for asm-generic, so I'd prefer if someone
> > else could merge them.
>
> Not sure where else it would fit.  It is in support for the RISC-V
> nommu port, but that isn't ready for the merge window.

If RISC-V want it, I don't see a problem with merging those patches
as preparation through the riscv git tree with my Ack for the asm-generic
portion.

      Arnd
