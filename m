From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] mm: convert k{un}map_atomic(p, KM_type) to
 k{un}map_atomic(p)
Date: Mon, 29 Aug 2011 14:33:05 +0200
Message-ID: <1314621185.2816.16.camel@twins>
References: <1314346676.6486.25.camel@minggr.sh.intel.com>
	 <1314349096.26922.21.camel@twins>
	 <20110826124239.fc503491.akpm@linux-foundation.org>
	 <20110826204053.GA3408@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33822 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab1H2MdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2011 08:33:14 -0400
In-Reply-To: <20110826204053.GA3408@elliptictech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Bowler <nbowler@elliptictech.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lin Ming <ming.m.lin@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org

On Fri, 2011-08-26 at 16:40 -0400, Nick Bowler wrote:
> > Extra marks will be awarded for
> > working out how to make unconverted code generate a compile warning ;)
> 
> It's possible to (ab)use the C preprocessor to accomplish this sort of
> thing.  For instance, consider the following:
> 
>   #include <stdio.h>
> 
>   int foo(int x)
>   {
>      return x;
>   }
> 
>   /* Deprecated; call foo instead. */
>   static inline int __attribute__((deprecated)) foo_unconverted(int x, int unused)
>   {
>      return foo(x);
>   }
> 
>   #define PASTE(a, b) a ## b
>   #define PASTE2(a, b) PASTE(a, b)
>   
>   #define NARG_(_9, _8, _7, _6, _5, _4, _3, _2, _1, n, ...) n
>   #define NARG(...) NARG_(__VA_ARGS__, 9, 8, 7, 6, 5, 4, 3, 2, 1, :)
> 
>   #define foo1(...) foo(__VA_ARGS__)
>   #define foo2(...) foo_unconverted(__VA_ARGS__)
>   #define foo(...) PASTE2(foo, NARG(__VA_ARGS__)(__VA_ARGS__))

Very neat ;-)
