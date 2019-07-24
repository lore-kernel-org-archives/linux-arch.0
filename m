From: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Date: Wed, 24 Jul 2019 14:45:52 -0400
Message-ID: <1563993952.11067.15.camel@lca.pw>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
         <31573.1563954571@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <31573.1563954571@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2019-07-24 at 08:49 +0100, David Howells wrote:
> Qian Cai <cai@lca.pw> wrote:
> 
> > Fix it by moving almost all of this multi-line macro into a proper
> > function __get_order(), and leave get_order() as a single-line macro in
> > order to avoid compilation errors.
> 
> The idea was that you could compile-time initialise a global variable with
> get_order():
> 
> 	int a = get_order(SOME_MACRO);
> 
> This is the same reason that ilog2() is a macro:
> 
> 	int a = ilog2(SOME_MACRO);
> 
> See the banner comment on get_order():
> 
>  * This function may be used to initialise variables with compile time
>  * evaluations of constants.
> 
> If you're moving the constant branch into __get_order(), an inline function,
> then we'll no longer be able to do this and you need to modify the comment
> too.  In fact, would there still be a point in having the get_order() macro?
> 
> Also, IIRC, older versions of gcc see __builtin_constant_p(n) == 0 inside an
> function, inline or otherwise, even if the passed-in argument *is* constant.

I have GCC 8.2.1 which works fine.

# cat const.c 
#include <stdio.h>

static int i = 0;

static inline void check()
{
	if (__builtin_constant_p(i))
		printf("i is a const.\n");
}

void main()
{
	check();
}

# gcc -O2 const.c -o const

# ./const 
i is a const.
