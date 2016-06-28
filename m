From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 02/29] rxrpc: Avoid using stack memory in SG lists in rxkad
Date: Tue, 28 Jun 2016 08:41:02 +0100
Message-ID: <32511.1467099662@warthog.procyon.org.uk>
References: <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <kernel-hardening-return-3745-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org>
Content-ID: <32510.1467099662.1@warthog.procyon.org.uk>
To: Andy Lutomirski <luto@kernel.org>
Cc: dhowells@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: linux-arch.vger.kernel.org

You should also note there's a pile of rxrpc patches in net-next that might
cause your patch problems.

David
