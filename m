From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Fri, 24 Jan 2020 09:33:07 +0100
Message-ID: <20200124083307.GA14914@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXIdP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 03:33:15 -0500
Content-Disposition: inline
In-Reply-To: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Thu, Jan 23, 2020 at 09:59:03AM -0800, Linus Torvalds wrote:
> On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
> >
> > This is version two of the patches I previously posted as an RFC here:
> 
> Looks fine to me, as far as I can tell,

Awesome, I've picked them up with a target for tip/locking/core.
