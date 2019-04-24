Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXG5l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Apr 2019 02:57:41 -0400
Date: Wed, 24 Apr 2019 08:57:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Does vdso_install attempt to re-compile objects under root
 privilege?
Message-ID: <20190424065738.GD4038@hirez.programming.kicks-ass.net>
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
 <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190424065738.Ew5gFjiQ1dTKXqjxGxOcFujWbaeSmiR3T3rP-vWTA4g@z>

On Tue, Apr 23, 2019 at 04:38:35PM -0700, Linus Torvalds wrote:

> So anybody who builds the kernel as root is doing something seriously
> wrong, in my opinion.

Some of my test boxes don't have a user account... if they fall over,
I'll just re-image them.

So I've been doing it wrong?
