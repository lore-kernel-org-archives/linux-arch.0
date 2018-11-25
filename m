Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36804 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeKYOtZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Nov 2018 09:49:25 -0500
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-3-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-3-deepa.kernel@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 24 Nov 2018 22:58:39 -0500
Message-ID: <CAF=yD-KfxXK=Ta=+a8UYMcmUYzN=UokotfzSno2-xi=JeS6=0g@mail.gmail.com>
Subject: Re: [PATCH 2/8] sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>, David Howells <dhowells@redhat.com>, jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net, linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, sparclinux@vger.kernel.org
Message-ID: <20181125035839.lq5QlFQwhPGnm97W4uwYw1ozL_jV9LGE0pw2MAJPNlg@z>

On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING options, the
> way they are currently defined, are not y2038 safe.
> Subsequent patches in the series add new y2038 safe versions
> of these options which provide 64 bit timestamps on all
> architectures uniformly.
> Hence, rename existing options with OLD tag suffixes.

Why do the existing interfaces have to be renamed when new interfaces are added?
