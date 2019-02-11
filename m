Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51776 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389928AbfBKPat (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 10:30:49 -0500
Date: Mon, 11 Feb 2019 15:30:43 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy
 ordering for port I/O accesses
Message-ID: <20190211153043.GC32385@fuggles.cambridge.arm.com>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-5-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109210748.29074-5-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, David Laight <David.Laight@ACULAB.COM>, linux-doc@vger.kernel.org
Message-ID: <20190211153043.VdBszM72HkGwWHDRNpUSlZhBK-YPuC2R8sAnHVbYERE@z>

Hi Paul,

On Wed, Jan 09, 2019 at 01:07:46PM -0800, Paul E. McKenney wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> David Laight explains:
> 
>   | A long time ago there was a document from Intel that said that
>   | inb/outb weren't necessarily synchronised wrt memory accesses.
>   | (Might be P-pro era). However no processors actually behaved that
>   | way and more recent docs say that inb/outb are fully ordered.
> 
> This also reflects the situation on other architectures, the the port
> accessor macros tend to be implemented in terms of readX/writeX.
> 
> Update Documentation/memory-barriers.txt to reflect reality.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <linux-arch@vger.kernel.org>
> Cc: <linux-doc@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  Documentation/memory-barriers.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1c22b21ae922..a70104e2a087 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2619,10 +2619,8 @@ functions:
>       intermediary bridges (such as the PCI host bridge) may not fully honour
>       that.
>  
> -     They are guaranteed to be fully ordered with respect to each other.
> -
> -     They are not guaranteed to be fully ordered with respect to other types of
> -     memory and I/O operation.
> +     They are guaranteed to be fully ordered with respect to each other and
> +     also with respect to other types of memory and I/O operation.

Given the lack of Intel response here, I went away to do some digging.
As evidenced by the commit message, there is certainly an understanding
amongst some developers that inX/outX() are strongly ordered on x86 and
this was re-enforced by Linus in March last year:

https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg131212.html

It was this information on which I based my patch. The Intel SDM is not
quite as assertive in its claims.

However, it has also occurred to me that this patch is actually missing
the point. memory-barriers.txt should be documenting the *Linux* memory
model, not the x86 one, and so the port accessors should be defined to
have the same ordering semantics as the MMIO accessors. If this wasn't
the case, then macros such as ioreadX() and iowriteX() would be unusable
in portable driver code. The inX/outX implementation in asm-generic would
also be bogus, despite being widely used.

Unfortunately, the whole "KERNEL I/O BARRIER EFFECTS" section in
memory-barriers.txt is vague, x86-centric and out of date. I think the
best way forward is for me to propose a rewrite of that section, based
on the work I did putting together my I/O ordering talk at ELCE last
year. That, at least, will allow us to start off with a portable
semantics rather than trying to infer the details from CPU manuals.

So please drop this for now, and I'll send out a more involved RFC patch
shortly with the usual suspects on cc.

Cheers,

Will
