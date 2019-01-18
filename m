Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37209 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfARQYA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2019 11:24:00 -0500
MIME-Version: 1.0
References: <20190118161440.220134-1-jannh@google.com>
In-Reply-To: <20190118161440.220134-1-jannh@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 17:23:42 +0100
Message-ID: <CAK8P3a1o2EbMD6LnD78MFSD_VN5W64MACv-28P9ojPJT4k7i5Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, alpha <linux-alpha@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20190118162342.P4Hbf3kfynR_jSs22t6_JYz9BbFJrW_Rzf6PHg8ZO_A@z>

On Fri, Jan 18, 2019 at 5:15 PM Jann Horn <jannh@google.com> wrote:
>
> Multiple filesystems can already return EFSCORRUPTED errors to userspace;
> however, so far, definitions of EFSCORRUPTED were in filesystem-private
> headers.
>
> I wanted to use EUCLEAN to indicate data corruption in the VFS layer;
> Dave Chinner says that I should instead hoist the definitions of
> EFSCORRUPTED into the UAPI header and then use EFSCORRUPTED.
>
> This patch is marked for stable backport because it is a prerequisite for
> the following patch.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/ext2/ext2.h                   | 1 -
>  fs/ext4/ext4.h                   | 1 -
>  fs/xfs/xfs_linux.h               | 1 -
>  include/linux/jbd2.h             | 1 -
>  include/uapi/asm-generic/errno.h | 1 +
>  5 files changed, 1 insertion(+), 4 deletions(-)


For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
