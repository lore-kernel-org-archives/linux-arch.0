Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:41176 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfBYKNR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Feb 2019 05:13:17 -0500
Date: Mon, 25 Feb 2019 11:13:07 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 07/28] x86/asm/crypto: annotate local functions
Message-ID: <20190225101307.GD26145@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-8-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-8-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-crypto@vger.kernel.org
Message-ID: <20190225101307.DlDmEawjafo_4pb2rerP9OaKT1JP3pEJyBWAXlZcdP4@z>

On Wed, Jan 30, 2019 at 01:46:50PM +0100, Jiri Slaby wrote:
> Use the newly added SYM_FUNC_START_LOCAL to annotate starts of all
> functions which do not have ".globl" annotation, but their ends are
> annotated by ENDPROC. This is needed to balance ENDPROC for tools that
> generate debuginfo.
> 
> To be symmetric, we also convert their ENDPROCs to the new SYM_FUNC_END.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: <linux-crypto@vger.kernel.org>
> ---
>  arch/x86/crypto/aegis128-aesni-asm.S         |  8 ++--
>  arch/x86/crypto/aegis128l-aesni-asm.S        |  8 ++--
>  arch/x86/crypto/aegis256-aesni-asm.S         |  8 ++--
>  arch/x86/crypto/aesni-intel_asm.S            | 49 ++++++++------------
>  arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 20 ++++----
>  arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 20 ++++----
>  arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  8 ++--
>  arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  8 ++--
>  arch/x86/crypto/chacha-ssse3-x86_64.S        |  4 +-
>  arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
>  arch/x86/crypto/morus1280-avx2-asm.S         | 16 +++----
>  arch/x86/crypto/morus1280-sse2-asm.S         | 16 +++----
>  arch/x86/crypto/morus640-sse2-asm.S          | 16 +++----
>  arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  8 ++--
>  arch/x86/crypto/serpent-avx2-asm_64.S        |  8 ++--
>  arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  8 ++--
>  16 files changed, 100 insertions(+), 109 deletions(-)
> 
> diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
> index 5f7e43d4f64a..87b94664296a 100644
> --- a/arch/x86/crypto/aegis128-aesni-asm.S
> +++ b/arch/x86/crypto/aegis128-aesni-asm.S
> @@ -74,7 +74,7 @@
>   *   %r8
>   *   %r9
>   */
> -__load_partial:
> +SYM_FUNC_START_LOCAL(__load_partial)

Btw, here's what I mean with it being problematic when the global symbol
names are not distinctive enough:

arch/x86/crypto/aegis128-aesni-asm.S:77:SYM_FUNC_START_LOCAL(__load_partial)
arch/x86/crypto/aegis128l-aesni-asm.S:68:SYM_FUNC_START_LOCAL(__load_partial)
arch/x86/crypto/aegis256-aesni-asm.S:61:SYM_FUNC_START_LOCAL(__load_partial)
arch/x86/crypto/morus1280-avx2-asm.S:115:SYM_FUNC_START_LOCAL(__load_partial)
arch/x86/crypto/morus1280-sse2-asm.S:237:SYM_FUNC_START_LOCAL(__load_partial)
arch/x86/crypto/morus640-sse2-asm.S:115:SYM_FUNC_START_LOCAL(__load_partial)

There are a bunch of those __{load,store}_partial labels and staring at
traces with them in it does not really help, unless you know which one
is it.

Should not be addressed by your patchset but those should be local
labels...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
