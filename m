Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-09.nifty.com ([202.248.20.74]:37256 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdCNFqF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2017 01:46:05 -0400
MIME-Version: 1.0
In-Reply-To: <96811b2b-25af-ed32-5094-14987aefd4d2@6wind.com>
References: <20170301045241.GB9156@gondor.apana.org.au> <1488473802-13354-1-git-send-email-nicolas.dichtel@6wind.com>
 <3df45ecc-1aa0-a029-d7e5-2598f0908874@6wind.com> <CAK7LNARpx7f0eV5_AiPmNYT7MsRbGFOygJwjfAzX_7aCpuHwuw@mail.gmail.com>
 <96811b2b-25af-ed32-5094-14987aefd4d2@6wind.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 14 Mar 2017 14:38:29 +0900
Message-ID: <CAK7LNAQV0tDw7RCTdn-qicttbyjU9QRfxasvc-7S-+dxMfii8g@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] uapi: export all headers under uapi directories
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, "David S. Miller" <davem@davemloft.net>, Russell King <linux@armlinux.org.uk>, bp@alien8.de, slash.tmp@free.fr, Daniel Vetter <daniel.vetter@ffwll.ch>, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, Tobias Klauser <tklauser@distanz.ch>, mpe@ellerman.id.au, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ldv@altlinux.org, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org
Message-ID: <20170314053829.oa1lAje3I7tZ5UI12PhBCkNNNEk5jHNqIuVh9EI94rc@z>

Ni Nicolas,


2017-03-14 1:57 GMT+09:00 Nicolas Dichtel <nicolas.dichtel@6wind.com>:
>> BTW, this series does not apply cleanly.
>>
>> If you could rebase it onto v4.11-rc1 tag,
>> it would be helpful.
> You really want this on top of 4.11-rc1 or the last linus tag, ie v4.11-rc2?
>

Basically, I queue up patches based on -rc1 tag
unless there is a particular reason for otherwise.

If it is based on -rc1, will it cause conflicts with Linus tree?


-- 
Best Regards
Masahiro Yamada
