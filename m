Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbfGAEEg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 00:04:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6141V8L056277
        for <linux-arch@vger.kernel.org>; Mon, 1 Jul 2019 00:04:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tf9k9agpj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 01 Jul 2019 00:04:35 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Jul 2019 05:04:34 +0100
Date: Sun, 30 Jun 2019 21:04:30 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] tools/memory-model: Update the informal documentation
Reply-To: paulmck@linux.ibm.com
References: <1561842644-5354-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561842644-5354-1-git-send-email-andrea.parri@amarulasolutions.com>
Message-ID: <20190701040430.GY26519@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190701040430.MW1-j1HoZ1tQjFb3WOOwvY0Tl35_lPdcARmD32aSgTU@z>

On Sat, Jun 29, 2019 at 11:10:44PM +0200, Andrea Parri wrote:
> The formal memory consistency model has added support for plain accesses
> (and data races).  While updating the informal documentation to describe
> this addition to the model is highly desirable and important future work,
> update the informal documentation to at least acknowledge such addition.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>

Queued for review, thank you, Andrea!

							Thanx, Paul

> ---
>  tools/memory-model/Documentation/explanation.txt | 47 +++++++++++-------------
>  tools/memory-model/README                        | 18 ++++-----
>  2 files changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 68caa9a976d0c..b42f7cd718242 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -42,7 +42,8 @@ linux-kernel.bell and linux-kernel.cat files that make up the formal
>  version of the model; they are extremely terse and their meanings are
>  far from clear.
>  
> -This document describes the ideas underlying the LKMM.  It is meant
> +This document describes the ideas underlying the LKMM, but excluding
> +the modeling of bare C (or plain) shared memory accesses.  It is meant
>  for people who want to understand how the model was designed.  It does
>  not go into the details of the code in the .bell and .cat files;
>  rather, it explains in English what the code expresses symbolically.
> @@ -354,31 +355,25 @@ be extremely complex.
>  Optimizing compilers have great freedom in the way they translate
>  source code to object code.  They are allowed to apply transformations
>  that add memory accesses, eliminate accesses, combine them, split them
> -into pieces, or move them around.  Faced with all these possibilities,
> -the LKMM basically gives up.  It insists that the code it analyzes
> -must contain no ordinary accesses to shared memory; all accesses must
> -be performed using READ_ONCE(), WRITE_ONCE(), or one of the other
> -atomic or synchronization primitives.  These primitives prevent a
> -large number of compiler optimizations.  In particular, it is
> -guaranteed that the compiler will not remove such accesses from the
> -generated code (unless it can prove the accesses will never be
> -executed), it will not change the order in which they occur in the
> -code (within limits imposed by the C standard), and it will not
> -introduce extraneous accesses.
> -
> -This explains why the MP and SB examples above used READ_ONCE() and
> -WRITE_ONCE() rather than ordinary memory accesses.  Thanks to this
> -usage, we can be certain that in the MP example, P0's write event to
> -buf really is po-before its write event to flag, and similarly for the
> -other shared memory accesses in the examples.
> -
> -Private variables are not subject to this restriction.  Since they are
> -not shared between CPUs, they can be accessed normally without
> -READ_ONCE() or WRITE_ONCE(), and there will be no ill effects.  In
> -fact, they need not even be stored in normal memory at all -- in
> -principle a private variable could be stored in a CPU register (hence
> -the convention that these variables have names starting with the
> -letter 'r').
> +into pieces, or move them around.  The use of READ_ONCE(), WRITE_ONCE(),
> +or one of the other atomic or synchronization primitives prevents a
> +large number of compiler optimizations.  In particular, it is guaranteed
> +that the compiler will not remove such accesses from the generated code
> +(unless it can prove the accesses will never be executed), it will not
> +change the order in which they occur in the code (within limits imposed
> +by the C standard), and it will not introduce extraneous accesses.
> +
> +The MP and SB examples above used READ_ONCE() and WRITE_ONCE() rather
> +than ordinary memory accesses.  Thanks to this usage, we can be certain
> +that in the MP example, the compiler won't reorder P0's write event to
> +buf and P0's write event to flag, and similarly for the other shared
> +memory accesses in the examples.
> +
> +Since private variables are not shared between CPUs, they can be
> +accessed normally without READ_ONCE() or WRITE_ONCE().  In fact, they
> +need not even be stored in normal memory at all -- in principle a
> +private variable could be stored in a CPU register (hence the convention
> +that these variables have names starting with the letter 'r').
>  
>  
>  A WARNING
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 2b87f3971548c..fc07b52f20286 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -167,15 +167,15 @@ scripts	Various scripts, see scripts/README.
>  LIMITATIONS
>  ===========
>  
> -The Linux-kernel memory model has the following limitations:
> -
> -1.	Compiler optimizations are not modeled.  Of course, the use
> -	of READ_ONCE() and WRITE_ONCE() limits the compiler's ability
> -	to optimize, but there is Linux-kernel code that uses bare C
> -	memory accesses.  Handling this code is on the to-do list.
> -	For more information, see Documentation/explanation.txt (in
> -	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
> -	and "A WARNING" sections).
> +The Linux-kernel memory model (LKMM) has the following limitations:
> +
> +1.	Compiler optimizations are not accurately modeled.  Of course,
> +	the use of READ_ONCE() and WRITE_ONCE() limits the compiler's
> +	ability to optimize, but under some circumstances it is possible
> +	for the compiler to undermine the memory model.  For more
> +	information, see Documentation/explanation.txt (in particular,
> +	the "THE PROGRAM ORDER RELATION: po AND po-loc" and "A WARNING"
> +	sections).
>  
>  	Note that this limitation in turn limits LKMM's ability to
>  	accurately model address, control, and data dependencies.
> -- 
> 2.7.4
> 
