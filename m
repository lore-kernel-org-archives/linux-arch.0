Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34709 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWT6n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 15:58:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id n68so9421291qka.1
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 12:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190423163809.9962-1-hch@lst.de> <CAK8P3a3D7F07kJAXp9yOh7FqEzL8rZeO5Xo9tGxpXFsibpShgg@mail.gmail.com>
 <20190423183232.GA26846@lst.de> <CAK8P3a35AD7p6aHS3B2ovZVVBnzEcc-Yt6c1xQHMdWkMY8fV7w@mail.gmail.com>
 <20190423193645.GA27933@lst.de>
In-Reply-To: <20190423193645.GA27933@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Apr 2019 21:58:25 +0200
Message-ID: <CAK8P3a29jtmzZ7BdngY05UDBOwvw6Xz1qFSKZ2xND0-7PJYcRQ@mail.gmail.com>
Subject: Re: kill <asm/segment.h> and improve nommu generic uaccess helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Tue, Apr 23, 2019 at 9:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Apr 23, 2019 at 08:41:02PM +0200, Arnd Bergmann wrote:
> > > Not sure where else it would fit.  It is in support for the RISC-V
> > > nommu port, but that isn't ready for the merge window.
> >
> > If RISC-V want it, I don't see a problem with merging those patches
> > as preparation through the riscv git tree with my Ack for the asm-generic
> > portion.
>
> We don't really need it this merge window and the patch stack is huge,
> so anything I can dash out earlier is a plus.
>
> I could offer you to send the asm-generic pull request to Linus if
> you're off after you have prepared everything else before leaving.

I can probably do it during the vacation. I've pushed the four branches
out for linux-next now and added a signed tag 'asm-generic-nommu' on my
asm-generic git tree, so sending out the pull request should be a matter
of minutes even when I'm travelling.

       Arnd
