Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKOoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Dec 2018 09:44:00 -0500
Date: Tue, 11 Dec 2018 15:43:54 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files
 with double quotes
Message-ID: <20181211144354.GA89489@gmail.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
 <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org
Message-ID: <20181211144354.LQn8J44beJwXz0UKd5_CmAeQaaEcMQGe058VPxiCcIo@z>


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
> 
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
> 
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
> 
> Make it treewide consistent now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks for doing all this Kconfig language work!

Thanks,

	Ingo
