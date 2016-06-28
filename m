From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v4 02/29] rxrpc: Avoid using stack memory in SG lists in
 rxkad
Date: Tue, 28 Jun 2016 15:37:42 +0800
Message-ID: <20160628073742.GA15496@gondor.apana.org.au>
References: <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org>
 <cover.1466974736.git.luto@kernel.org>
 <cover.1466974736.git.luto@kernel.org>
 <32026.1467099166@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:58098 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcF1Hhx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2016 03:37:53 -0400
Content-Disposition: inline
In-Reply-To: <32026.1467099166@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Tue, Jun 28, 2016 at 08:32:46AM +0100, David Howells wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
> 
> > @@ -277,6 +277,7 @@ struct rxrpc_connection {
> >  	struct key		*key;		/* security for this connection (client) */
> >  	struct key		*server_key;	/* security for this service */
> >  	struct crypto_skcipher	*cipher;	/* encryption handle */
> > +	struct rxrpc_crypt	csum_iv_head;	/* leading block for csum_iv */
> >  	struct rxrpc_crypt	csum_iv;	/* packet checksum base */
> >  	unsigned long		events;
> >  #define RXRPC_CONN_CHALLENGE	0		/* send challenge packet */
> 
> NAK.  This won't work.  csum_iv_head is per packet being processed, but you've
> put it in rxrpc_connection which is shared amongst several creators/digestors
> of packets.  Putting it in rxrpc_call won't work either since it's also needed
> for connection level packets.

Huh? If you can't write to csum_iv_head without clobbering others
then by the same reasoning you can't write to csum_iv either.  So
unless you're saying the existing code is already broken then there
is nothing wrong with the patch.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
