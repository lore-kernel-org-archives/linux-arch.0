Return-Path: <SRS0=84jE=65=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-co1nam11on2110.outbound.protection.outlook.com ([40.107.220.110]:43617
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbgEOQHn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 12:07:43 -0400
From: "Karstens, Nate" <Nate.Karstens@garmin.com>
Subject: RE: [PATCH v2] Implement close-on-fork
Date: Fri, 15 May 2020 16:07:33 +0000
Message-ID: <5b1929aa9f424e689c7f430663891827@garmin.com>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <20200515155730.GF16070@bombadil.infradead.org>
In-Reply-To: <20200515155730.GF16070@bombadil.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Changli Gao <xiaosuo@gmail.com>, "a.josey@opengroup.org" <a.josey@opengroup.org>
Message-ID: <20200515160733.gD2yx7GtW0I6ipi5FlwVuHQk2oxSn1DbgnQxTS-thbU@z>

Matthew,

What alternative would you suggest?

From an earlier email:

> ...nothing else addresses the underlying issue: there is no way to
> prevent a fork() from duplicating the resource. The close-on-exec
> flag partially-addresses this by allowing the parent process to
> mark a file descriptor as exclusive to itself, but there is still
> a period of time the failure can occur because the auto-close only
> occurs during the exec(). Perhaps this would not be an issue with
> a different process/threading model, but that is another discussion
> entirely.

Do you disagree there is an issue?

-----Original Message-----
From: Matthew Wilcox <willy@infradead.org>
Sent: Friday, May 15, 2020 10:58
To: Karstens, Nate <Nate.Karstens@garmin.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>; Jeff Layton <jlayton@kernel.o=
rg>; J. Bruce Fields <bfields@fieldses.org>; Arnd Bergmann <arnd@arndb.de>;=
 Richard Henderson <rth@twiddle.net>; Ivan Kokshaysky <ink@jurassic.park.ms=
u.ru>; Matt Turner <mattst88@gmail.com>; James E.J. Bottomley <James.Bottom=
ley@hansenpartnership.com>; Helge Deller <deller@gmx.de>; David S. Miller <=
davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet <eduma=
zet@google.com>; David Laight <David.Laight@aculab.com>; linux-fsdevel@vger=
.kernel.org; linux-arch@vger.kernel.org; linux-alpha@vger.kernel.org; linux=
-parisc@vger.kernel.org; sparclinux@vger.kernel.org; netdev@vger.kernel.org=
; linux-kernel@vger.kernel.org; Changli Gao <xiaosuo@gmail.com>; a.josey@op=
engroup.org
Subject: Re: [PATCH v2] Implement close-on-fork

CAUTION - EXTERNAL EMAIL: Do not click any links or open any attachments un=
less you trust the sender and know the content is safe.


On Fri, May 15, 2020 at 10:23:17AM -0500, Nate Karstens wrote:
> Series of 4 patches to implement close-on-fork. Tests have been
> published to https://github.com/nkarstens/ltp/tree/close-on-fork
> and cover close-on-fork functionality in the following syscalls:

[...]

> This functionality was approved by the Austin Common Standards
> Revision Group for inclusion in the next revision of the POSIX
> standard (see issue 1318 in the Austin Group Defect Tracker).

NAK to this patch series, and the entire concept.

Is there a way to persuade POSIX that they made a bad decision by standardi=
sing this mess?

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
