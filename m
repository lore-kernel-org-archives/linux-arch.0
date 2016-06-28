From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 02/29] rxrpc: Avoid using stack memory in SG lists in rxkad
Date: Tue, 28 Jun 2016 11:00:30 +0100
Message-ID: <14865.1467108030@warthog.procyon.org.uk>
References: <20160628094357.GA16467@gondor.apana.org.au> <20160628075546.GA15690@gondor.apana.org.au> <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <699.1467100340@warthog.procyon.org.uk> <4339.1467104063@warthog.procyon.org.uk>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <kernel-hardening-return-3752-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <20160628094357.GA16467@gondor.apana.org.au>
Content-ID: <14864.1467108030.1@warthog.procyon.org.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > I'm using the per-skb state for my own purposes and might be looking at it
> > elsewhere at the same time.
> 
> AFAICS this cannot happen for secure_packet/verify_packet.  In both
> cases we have exclusive ownership of the skb.

In code I'm busy working on the patch I'm decrypting may be on the receive
queue several times.  rxrpc has a jumbo packet concept whereby a packet may be
constructed in such a way that it's actually several packets stitched together
- the idea being that a router can split it up (not that any actually do that
I know of) - but each segment of the jumbo packet may be enqueued as a
separate entity.

> But it's your code so feel free to send your own patch.

I will apply something very similar to my tree.  Andy's patch does not apply
as-is due to conflicts.

David
