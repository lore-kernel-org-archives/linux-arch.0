Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34806 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWS1r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 14:27:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id y16so3589105ljg.1
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190423163809.9962-1-hch@lst.de>
In-Reply-To: <20190423163809.9962-1-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Apr 2019 20:27:29 +0200
Message-ID: <CAK8P3a3D7F07kJAXp9yOh7FqEzL8rZeO5Xo9tGxpXFsibpShgg@mail.gmail.com>
Subject: Re: kill <asm/segment.h> and improve nommu generic uaccess helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Tue, Apr 23, 2019 at 6:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Arnd,
>
> this is a series doing two somewhat interwinded things.  It improves
> the asm-generic nommu uaccess helper to optionally be entirely generic
> and not require any arch helpers for the actual uaccess.  For the
> generic uaccess.h to actually be generically useful I also had to kill
> off the mess we made of <asm/segment.h>, which really shouldn't exist
> on most architectures.

This looks really nice, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

Should I pick this up into my asm-generic tree, or do you have another tree
that this fits into? I might be on vacation during the entire merge window
this time and don't have anything else for asm-generic, so I'd prefer if someone
else could merge them.

I've also added the patches to my randconfig build tree (building x86, arm
and arm64 randconfigs at the moment). I expect it to be fine, but I'll let
you know if something breaks.

        Arnd
