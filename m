From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Date: Wed, 24 Jul 2019 08:49:31 +0100
Message-ID: <31573.1563954571@warthog.procyon.org.uk>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1563914986-26502-1-git-send-email-cai@lca.pw>
Content-ID: <31572.1563954571.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Qian Cai <cai@lca.pw> wrote:

> Fix it by moving almost all of this multi-line macro into a proper
> function __get_order(), and leave get_order() as a single-line macro in
> order to avoid compilation errors.

The idea was that you could compile-time initialise a global variable with
get_order():

	int a = get_order(SOME_MACRO);

This is the same reason that ilog2() is a macro:

	int a = ilog2(SOME_MACRO);

See the banner comment on get_order():

 * This function may be used to initialise variables with compile time
 * evaluations of constants.

If you're moving the constant branch into __get_order(), an inline function,
then we'll no longer be able to do this and you need to modify the comment
too.  In fact, would there still be a point in having the get_order() macro?

Also, IIRC, older versions of gcc see __builtin_constant_p(n) == 0 inside an
function, inline or otherwise, even if the passed-in argument *is* constant.

David
