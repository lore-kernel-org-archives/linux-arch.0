Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35160 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKAU5n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Nov 2019 16:57:43 -0400
MIME-Version: 1.0
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
In-Reply-To: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Nov 2019 21:57:31 +0100
Message-ID: <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org, Ext4 Developers List <linux-ext4@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20191101205731.6ho566PQtY9nDDs7cBib3OynCqCPgezHGDHiAC8Cia4@z>

Hi Valdis,

On Thu, Oct 31, 2019 at 2:11 AM Valdis Kletnieks
<valdis.kletnieks@vt.edu> wrote:
> Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> (c) if one patch, who gets to shepherd it through?
>
> There's currently 6 filesystems that have the same #define. Move it
> into errno.h so it's defined in just one place.
>
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Thanks for your patch!

> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -98,6 +98,7 @@
>  #define        EINPROGRESS     115     /* Operation now in progress */
>  #define        ESTALE          116     /* Stale file handle */
>  #define        EUCLEAN         117     /* Structure needs cleaning */
> +#define        EFSCORRUPTED    EUCLEAN

I have two questions:
a) Why not use EUCLEAN everywhere instead?
    Having two different names for the same errno complicates grepping.
b) Perhaps both errors should use different values? Do they have the
   same semantics? I'm not a fs developer, so this is a bit fuzzy to me.
   According to Documentation/, one seems to originate in mtd, the
   other in xfs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
