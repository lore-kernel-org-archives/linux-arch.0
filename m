Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43209 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfBHVTL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 16:19:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id f196so2519788qke.10
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 13:19:11 -0800 (PST)
Date: Fri, 8 Feb 2019 16:19:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
Message-ID: <20190208161820-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190208181246.GF11096@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208181246.GF11096@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190208211907.poEkInMbuKZ7162YhkKNweeSpqDMGgH579_KprKUKM8@z>

On Fri, Feb 08, 2019 at 08:12:47PM +0200, Mike Rapoport wrote:
> On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> > Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> > architectures, it probably makes sense to de-duplicate these
> > and put them into a common header.
> 
> I like the idea, but it seems there are more asm/mman.h users than just mpx
> and drm.
> 
> Any reason only those were updated to include linux/mman.h?


They are all .c files. So since they keep building I know
nothing else will break. Fixing them would be an unrelated
cleanup.



>  
> > Please review and consider merging though the generic tree.
> > 
> > Build tested on x86 only. Has been in linux-next for a while now.
> > 
> > Michael S. Tsirkin (3):
> >   x86/mpx: tweak header name
> >   drm: tweak header name
> >   arch: move common mmap flags to linux/mman.h
> > 
> >  arch/alpha/include/uapi/asm/mman.h     | 4 +---
> >  arch/mips/include/uapi/asm/mman.h      | 4 +---
> >  arch/parisc/include/uapi/asm/mman.h    | 4 +---
> >  arch/x86/mm/mpx.c                      | 2 +-
> >  arch/xtensa/include/uapi/asm/mman.h    | 4 +---
> >  include/drm/drmP.h                     | 3 +--
> >  include/uapi/asm-generic/mman-common.h | 4 +---
> >  include/uapi/linux/mman.h              | 4 ++++
> >  8 files changed, 11 insertions(+), 18 deletions(-)
> > 
> > -- 
> > MST
> > 
> 
> -- 
> Sincerely yours,
> Mike.
