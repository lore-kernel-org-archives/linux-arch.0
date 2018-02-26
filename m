Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53967 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBZH7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Feb 2018 02:59:35 -0500
Date: Mon, 26 Feb 2018 08:59:31 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH/RFC] headers: drop 2 #included headers from
 <linux/interrupt.h>
Message-ID: <20180226075931.5vn4vdbfcsje2z56@gmail.com>
References: <b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org>
 <20180216075942.kmgdyvmluke2s5vg@gmail.com>
 <87bmgc3bdv.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmgc3bdv.fsf@rasmusvillemoes.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180226075931.iaWJDvuYIpR6nZV_vMw7WtZBdVO4t_XQ_jp9K0B-QNw@z>


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> [...] Now I finally got around to writing some scripts for that, so here's a 
> visualization of (the evolution of) the problem:
> 
> https://wildmoose.dk/header-bloat/

Nice! In particular your final conclusion is impressive and scary:

> So the typical (median) translation unit ends up including over 450 headers 
> files, making the whole TU about 200 times bigger than the .c file itself, while 
> more than 25% of the translation units get bloated to over 400 times the size of 
> the .c file.

Even with a lot of this being eliminated at fairly early compiling stages that's a 
*huge* chunk of code that needs to be parsed again and again and again and again 
...

> I hope to find some time soonish to polish the old programs and see if they 
> actually still work.

That would be lovely!

Thanks,

	Ingo
