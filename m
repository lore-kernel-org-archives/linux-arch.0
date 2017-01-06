From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: + find_bit-micro-optimise-find_next__bit.patch added to -mm tree
Date: Fri, 6 Jan 2017 13:37:55 +0530
Message-ID: <20170106080755.GA3991@yury-N73SV>
References: <586ef08a.yZe+xDRyhTV2fTqh%akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:23392
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966693AbdAFIIP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Jan 2017 03:08:15 -0500
Content-Disposition: inline
In-Reply-To: <586ef08a.yZe+xDRyhTV2fTqh%akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mawilcox@microsoft.com, akpm@linux-foundation.org
Cc: linux@rasmusvillemoes.dk, linux-arch@vger.kernel.org, mm-commits@vger.kernel.org

NACK.

I acked it in assumption that Matthew will send v2 that also fixes 
_find_next_bit_le() the same way.

Yury

On Thu, Jan 05, 2017 at 05:19:06PM -0800, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: lib/find_bit.c: micro-optimise find_next_*_bit
> has been added to the -mm tree.  Its filename is
>      find_bit-micro-optimise-find_next__bit.patch
> 
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/find_bit-micro-optimise-find_next__bit.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/find_bit-micro-optimise-find_next__bit.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
> 
> ------------------------------------------------------
> From: Matthew Wilcox <mawilcox@microsoft.com>
> Subject: lib/find_bit.c: micro-optimise find_next_*_bit
> 
> This saves 20 bytes on my x86-64 build, mostly due to alignment
> considerations ...  I think it actually saves about five bytes of
> instructions.  There's really two parts to this commit.  First, the first
> half of the test: (!nbits || start >= nbits) is trivially a subset of the
> second half, since nbits and start are both unsigned.  Second, while
> looking at the disassembly, I noticed that GCC was predicting the branch
> taken.  Since this is a failure case, it's clearly the less likely of the
> two branches, so add an unlikely() to override GCC's heuristics.
> 
> Link: http://lkml.kernel.org/r/1482513603-9630-1-git-send-email-mawilcox@linuxonhyperv.com
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Acked-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  lib/find_bit.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN lib/find_bit.c~find_bit-micro-optimise-find_next__bit lib/find_bit.c
> --- a/lib/find_bit.c~find_bit-micro-optimise-find_next__bit
> +++ a/lib/find_bit.c
> @@ -33,7 +33,7 @@ static unsigned long _find_next_bit(cons
>  {
>  	unsigned long tmp;
>  
> -	if (!nbits || start >= nbits)
> +	if (unlikely(start >= nbits))
>  		return nbits;
>  
>  	tmp = addr[start / BITS_PER_LONG] ^ invert;
> _
> 
> Patches currently in -mm which might be from mawilcox@microsoft.com are
> 
> find_bit-micro-optimise-find_next__bit.patch
> reimplement-idr-and-ida-using-the-radix-tree-support-storing-null-in-the-idr.patch
