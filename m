Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35538 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDHN7C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Apr 2019 09:59:02 -0400
MIME-Version: 1.0
References: <20190408124640.GA607@lst.de>
In-Reply-To: <20190408124640.GA607@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 8 Apr 2019 15:58:44 +0200
Message-ID: <CAK8P3a13NVbkJzzoZG_7HrDT9qGPR5ptbRUL=xH1oZ1a+5ksHw@mail.gmail.com>
Subject: Re: CONFIG_* symbols in UAPI headers?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jie Zhang <jie.zhang@analog.com>, Mike Frysinger <vapier@gentoo.org>, David Howells <dhowells@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190408135844.hYIeio2UW-yTdtfMFM5Tq2XS2VaoEaJoJDjAr_rSyng@z>

On Mon, Apr 8, 2019 at 2:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I just stumbled over the MAP_UNINITIALIZED defintion, initially
> added by:
>
> commit ea637639591def87a54cea811cbac796980cb30d
> Author: Jie Zhang <jie.zhang@analog.com>
> Date:   Mon Dec 14 18:00:02 2009 -0800
>
>     nommu: fix malloc performance by adding uninitialized flag
>
> The defintion depends on CONFIG_MMAP_ALLOW_UNINITIALIZED, which
> will never be set by userspace.  How is this supposed to work?
>
> Shoudn't we define the symbol unconditionally and just turn it
> into a no-op in the implementation?

Right, good catch. That should work. It can probably be done
by adding another check before the conditional, like:

       /* clear anonymous mappings that don't ask for uninitialized data */
       if (!vma->vm_file &&
           !(IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) &&
             (flags & MAP_UNINITIALIZED))
               memset((void *)region->vm_start, 0,
                      region->vm_end - region->vm_start);

> There are a few similar issues, like struct elf_prstatus having
> a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
> MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

I thought we had cleaned them out a long time ago, but it looks
like those have been there since the uapi headers got split out,
and are still wrong.

Why doesn't scripts/headers_check.pl find those?

      Arnd
