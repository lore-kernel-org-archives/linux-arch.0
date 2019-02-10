Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:37049 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBJWNB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 Feb 2019 17:13:01 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
In-Reply-To: <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-13-deepa.kernel@gmail.com> <87r2clku4j.fsf@concordia.ellerman.id.au> <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
Date: Mon, 11 Feb 2019 09:12:52 +1100
Message-ID: <87o97ji97f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, ccaulfie@redhat.com, Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, cluster-devel <cluster-devel@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>
Message-ID: <20190210221252.asBTwx_CKlQ5-2W-utmzyatXuNgF3qlrogW7UmDVpGU@z>

Deepa Dinamani <deepa.kernel@gmail.com> writes:

>> You touched powerpc in the previous patch but not this one.
>>
>> That's because we use the asm-generic version I assume.
>
> That is correct.
>
>> Would be good to mention in the change log though to avoid any confusion.
>
> I'm not sure how to do that now. It looks like the series has already
> been applied to net-next with a couple of merge conflicts fixed.

That's fine, it's not that important.

cheers
