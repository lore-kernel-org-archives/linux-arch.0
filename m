From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v4 02/29] rxrpc: Avoid using stack memory in SG lists in
 rxkad
Date: Tue, 28 Jun 2016 15:55:46 +0800
Message-ID: <20160628075546.GA15690@gondor.apana.org.au>
References: <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org>
 <cover.1466974736.git.luto@kernel.org>
 <cover.1466974736.git.luto@kernel.org>
 <699.1467100340@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:39154 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbcF1Hzw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2016 03:55:52 -0400
Content-Disposition: inline
In-Reply-To: <699.1467100340@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Tue, Jun 28, 2016 at 08:52:20AM +0100, David Howells wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
> 
> > -	skcipher_request_set_crypt(req, &sg[1], &sg[0], sizeof(tmpbuf), iv.x);
> > +	skcipher_request_set_crypt(req, &sg, &sg, sizeof(tmpbuf), iv.x);
> 
> Don't the sg's have to be different?  Aren't they both altered by the process
> of reading/writing from them?

No they don't have to be different.

> > 	struct rxrpc_skb_priv *sp;
> > ...
> > +	swap(tmpbuf.xl, *(__be64 *)sp);
> > +
> > +	sg_init_one(&sg, sp, sizeof(tmpbuf));
> 
> ????  I assume you're assuming that the rxrpc_skb_priv struct contents can
> arbitrarily replaced temporarily...

Of course you can, it's per-skb state.

> And using an XCHG-equivalent instruction?  This won't work on a 32-bit arch
> (apart from one that sports CMPXCHG8 or similar).

No this is not using an atomic xchg, whatever gave you that idea?
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
