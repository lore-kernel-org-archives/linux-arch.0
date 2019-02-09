Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:40427 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBIBos (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 20:44:48 -0500
MIME-Version: 1.0
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-13-deepa.kernel@gmail.com>
 <87r2clku4j.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2clku4j.fsf@concordia.ellerman.id.au>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 8 Feb 2019 17:44:34 -0800
Message-ID: <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, ccaulfie@redhat.com, Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, cluster-devel <cluster-devel@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>
Message-ID: <20190209014434.4XzR_saPBv4j41nP67r-4LjsPdfcNVbgOXrsWmue50s@z>

> You touched powerpc in the previous patch but not this one.
>
> That's because we use the asm-generic version I assume.

That is correct.

> Would be good to mention in the change log though to avoid any confusion.

I'm not sure how to do that now. It looks like the series has already
been applied to net-next with a couple of merge conflicts fixed.

-Deepa
