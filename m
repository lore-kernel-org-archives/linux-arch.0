From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 02/29] rxrpc: Avoid using stack memory in SG lists in rxkad
Date: Tue, 28 Jun 2016 09:54:23 +0100
Message-ID: <4339.1467104063@warthog.procyon.org.uk>
References: <20160628075546.GA15690@gondor.apana.org.au> <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <699.1467100340@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbcF1Iy2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jun 2016 04:54:28 -0400
In-Reply-To: <20160628075546.GA15690@gondor.apana.org.au>
Content-ID: <4338.1467104063.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > ????  I assume you're assuming that the rxrpc_skb_priv struct contents can
> > arbitrarily replaced temporarily...
> 
> Of course you can, it's per-skb state.

I'm using the per-skb state for my own purposes and might be looking at it
elsewhere at the same time.

David
