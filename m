Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34945 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdCCRQG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2017 12:16:06 -0500
Received: by mail-wr0-f174.google.com with SMTP id g10so77990816wrg.2
        for <linux-arch@vger.kernel.org>; Fri, 03 Mar 2017 09:16:05 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v9 00/11] uapi: export all headers under uapi directories
References: <20170301045241.GB9156@gondor.apana.org.au>
 <1488473802-13354-1-git-send-email-nicolas.dichtel@6wind.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <152f560b-c583-4aa4-a913-42c18a3cbd5f@6wind.com>
Date: Fri, 3 Mar 2017 18:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <1488473802-13354-1-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, mmarek@suse.com
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de, ldv@altlinux.org, herbert@gondor.apana.org.au, linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20170303170741.6dRf0d1q91X6i2UdSBUlymh04o26YFQMcZOZCgKOVXw@z>

Le 02/03/2017 à 17:56, Nicolas Dichtel a écrit :
> Patches #1 and #2 are just cleanup: some exported headers were still under
> a non-uapi directory. Patch #3 is a fix to avoid exporting a file that was
> not under an uapi directory.
> After these three patches, all exported headers are under an uapi directory:
> path #4 stops searching files in non uapi directories.
> The patch #5 was spotted by code review: there is no in-tree user of this
> functionality.
> Patch #6 fixes some warnings/errors reported by 0-day tests.
> Patch #7 to #9 fix some errors when the corresponding files are included by
> userland.
> Patches #10 and #11 remove the need to list explicitly headers. Now all files
> under an uapi directory are exported.
> 
> This series has been tested with a 'make headers_install' on x86 and a
> 'make headers_install_all'. I've checked the result of both commands.
> 
> This patch is built against linus tree. If I must rebase it against the kbuild
> tree, just tell me.
> Michal, is this series going through your tree?
I'm a bit pushy on this, but it would be nice to get this series in before the
rc1. In fact, it would certainly be better to have this living some times in
-next, but it would probably generate a lot of conflicts in linux-next. OTOH
those conflicts would be easy to solve.


Regards,
Nicolas
