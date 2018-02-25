Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50329 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeBYXT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Feb 2018 18:19:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id w128so8117421wmw.0
        for <linux-arch@vger.kernel.org>; Sun, 25 Feb 2018 15:19:59 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH/RFC] headers: drop 2 #included headers from <linux/interrupt.h>
References: <b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org>
        <20180216075942.kmgdyvmluke2s5vg@gmail.com>
Date: Mon, 26 Feb 2018 00:19:56 +0100
In-Reply-To: <20180216075942.kmgdyvmluke2s5vg@gmail.com> (Ingo Molnar's
        message of "Fri, 16 Feb 2018 08:59:42 +0100")
Message-ID: <87bmgc3bdv.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180225231956.0RTFDrHMPtsReYytW3m8uDijbQbpcn0-mqV_zQ1VEGE@z>

On Fri, Feb 16 2018, Ingo Molnar <mingo@kernel.org> wrote:

> * Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> Does anyone know or see why <linux/interrupt.h> needs <linux/linkage.h> or
>> <linux/preempt.h>?  There are no direct uses in <linux/interrupt.h> AFAICT.
>
> These are likely historical, plus it's a classic 'tragedy of the commons' 
> scenario: it's easy to take away from the "public good" of "clean header 
> dependencies" and very hard to add to it:
>
>  - it's very easy to add a new #include line
>
>  - it's very hard to remove one, not just due to the 2^10000 complex Kconfig
>    space, but due to 99% of the developers not testing cross-arch builds
>    (and we don't want to require them to do it)
>
>  - the cost of getting the removal wrong is high (the build breaks for many 
>    people who will be unhappy at the person removing the header), while the 
>    benefit of the removal is low in isolation
>
> Then apply this dynamic for more than 20 years and we get a spaghetti:
>
[snip]
>
> I'd argue that due to the basic human dynamics here this calls for tooling help.

I started trying to write some scripts a few years ago, but only got as
far as doing a pass over lib/ (e.g. b8b6db17) - but doing individual .c
files is never going to be enough; one really needs to eliminate
#includes from header files. But then I decided that before trying to
systematically attack that much bigger problem, I'd want some objective
metrics to see that it actually worked. Now I finally got around to
writing some scripts for that, so here's a visualization of
(the evolution of) the problem:

https://wildmoose.dk/header-bloat/

I hope to find some time soonish to polish the old programs and see if
they actually still work.

Rasmus
