Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbcF1HlH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jun 2016 03:41:07 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org>
References: <1eeb00c5098d8096cdb61dc7ee1ddc61b3e80f9e.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org>
Subject: Re: [PATCH v4 02/29] rxrpc: Avoid using stack memory in SG lists in rxkad
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32510.1467099662.1@warthog.procyon.org.uk>
Date: Tue, 28 Jun 2016 08:41:02 +0100
Message-ID: <32511.1467099662@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: dhowells@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20160628074102.mUalMdd0PL80WWD5hVuzrJybSRO2arXmcKV67Awh7go@z>

You should also note there's a pile of rxrpc patches in net-next that might
cause your patch problems.

David
