From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files
 with double quotes
Date: Tue, 11 Dec 2018 15:43:54 +0100
Message-ID: <20181211144354.GA89489@gmail.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
 <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org


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
