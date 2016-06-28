From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 02/29] rxrpc: Avoid using stack memory in SG lists in rxkad
Date: Tue, 28 Jun 2016 10:07:44 +0100
Message-ID: <5182.1467104864@warthog.procyon.org.uk>
References: <20160628073742.GA15496@gondor.apana.org.au> <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <32026.1467099166@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbcF1JHt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jun 2016 05:07:49 -0400
In-Reply-To: <20160628073742.GA15496@gondor.apana.org.au>
Content-ID: <5181.1467104864.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Huh? If you can't write to csum_iv_head without clobbering others
> then by the same reasoning you can't write to csum_iv either.  So
> unless you're saying the existing code is already broken then there
> is nothing wrong with the patch.

Ah, for some reason I read it as being in the normal packet processing.  Need
tea before I read security patches;-)

Since it's (more or less) a one off piece of memory, why not kmalloc it
temporarily rather than expanding the connection struct?  Also, the bit where
you put a second rxrpc_crypt in just so that it happens to give you a 16-byte
slot by adjacency is pretty icky.  It would be much better to use a union
instead:

	union {
		struct rxrpc_crypt	csum_iv; /* packet checksum base */
		__be32 tmpbuf[4];
	};

Note also that the above doesn't guarantee that the struct will be inside of a
single page.  It would need an alignment of 16 for that - but you only have
one sg.  Could that be a problem?

David
