Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from albireo.enyo.de ([5.158.152.32]:51904 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfCRJZJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Mar 2019 05:25:09 -0400
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
References: <20190311153857.563743-1-arnd@arndb.de>
        <87k1h1fgkk.fsf@mid.deneb.enyo.de>
        <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
        <87a7hvded7.fsf@mid.deneb.enyo.de>
        <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
        <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com>
Date: Mon, 18 Mar 2019 10:21:28 +0100
In-Reply-To: <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com>
        (Arnd Bergmann's message of "Mon, 18 Mar 2019 09:27:46 +0100")
Message-ID: <87o968y1uv.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "David S . Miller" <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>, alpha <linux-alpha@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Laura Abbott <labbott@redhat.com>, Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Josh Boyer <jwboyer@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Law <law@redhat.com>
Message-ID: <20190318092128.p7CDfezIvkev2w-uwtV6paL5z2PVFEu2M0Wv2e3s2qg@z>

* Arnd Bergmann:

> Should we just remove __kernel_fd_set from the exported headers and
> define the internal fd_set directly in include/linux/types.h? (Adding the
> folks from the old thread to Cc).

The type is used in the sanitizers, but incorrectly.  They assume that
FD_SETSIZE is always 1024.  (The existence of __kernel_fd_set is
itself somewhat questionable because it leads to such bugs.)  Moving
around the type could cause a build failure in the sanitizers, but I'm
not entirely clear how the UAPI headers are included there.

Otherwise, I couldn't find any uses.
