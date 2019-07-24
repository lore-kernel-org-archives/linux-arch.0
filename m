Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfGXHte (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jul 2019 03:49:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1563914986-26502-1-git-send-email-cai@lca.pw>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31572.1563954571.1@warthog.procyon.org.uk>
Date: Wed, 24 Jul 2019 08:49:31 +0100
Message-ID: <31573.1563954571@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190724074931.Q4JaAxHRos2pCaah4tjarnh0Y1Yjz-VoNmpy4-T3F2o@z>

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
