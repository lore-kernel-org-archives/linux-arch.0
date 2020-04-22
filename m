From: Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH 1/4] fs: Implement close-on-fork
Date: Wed, 22 Apr 2020 11:41:14 +0800
Message-ID: <CABa6K_Ev9d8wsb6HRCRPceOF7grDDjm41cV_CTjOiMHwoNsjTw@mail.gmail.com>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200420071548.62112-2-nate.karstens@garmin.com> <36dce9b4-a0bf-0015-f6bc-1006938545b1@gmail.com>
 <CABa6K_HWsy9DdjsKXE2d_JrC+OsNuW+OALS+-_HiV3r2XgC1bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726294AbgDVDl2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 23:41:28 -0400
In-Reply-To: <CABa6K_HWsy9DdjsKXE2d_JrC+OsNuW+OALS+-_HiV3r2XgC1bw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Nate Karstens <nate.karstens@garmin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 22, 2020 at 11:38 AM Changli Gao <xiaosuo@gmail.com> wrote:
> At the same time, we'd better extend other syscalls, which set the
> FD_CLOEXEC when  creating FDs. i.e. open, pipe3...
>

Ignore me, I missed the latter patches.



-- 
Regards,
Changli Gao(xiaosuo@gmail.com)
