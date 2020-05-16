Return-Path: <SRS0=0VUr=66=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34046 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgEPN3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 May 2020 09:29:51 -0400
Date: Sat, 16 May 2020 15:29:18 +0200
From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2] Implement close-on-fork
Message-ID: <20200516132918.edq7p2tyh6elorjm@wittgenstein>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <20200515155730.GF16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515155730.GF16070@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Nate Karstens <nate.karstens@garmin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Changli Gao <xiaosuo@gmail.com>, a.josey@opengroup.org
Message-ID: <20200516132918.TT-cZE11FRQsIuWW7c0ht-79M3Abogp4XFC9H8PO4iY@z>

On Fri, May 15, 2020 at 08:57:30AM -0700, Matthew Wilcox wrote:
> On Fri, May 15, 2020 at 10:23:17AM -0500, Nate Karstens wrote:
> > Series of 4 patches to implement close-on-fork. Tests have been
> > published to https://github.com/nkarstens/ltp/tree/close-on-fork
> > and cover close-on-fork functionality in the following syscalls:
> 
> [...]
> 
> > This functionality was approved by the Austin Common Standards
> > Revision Group for inclusion in the next revision of the POSIX
> > standard (see issue 1318 in the Austin Group Defect Tracker).
> 
> NAK to this patch series, and the entire concept.

Yeah.
But also, stuff like this should really be on linux-api.

Christian
