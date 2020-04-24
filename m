From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 07/11] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Date: Fri, 24 Apr 2020 19:43:34 +0200
Message-ID: <20200424174334.GB13592@hirez.programming.kicks-ass.net>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-8-will@kernel.org>
 <CAG48ez2n6g6nenHM8uB5U+e-Zo1PSA6n9LOBHeqG2HdUnwFpSQ@mail.gmail.com>
 <20200424171135.GJ21141@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbgDXRoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 13:44:18 -0400
Content-Disposition: inline
In-Reply-To: <20200424171135.GJ21141@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Jann Horn <jannh@google.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Fri, Apr 24, 2020 at 06:11:35PM +0100, Will Deacon wrote:
> My apologies, you're completely right. I thought that PAE mandated 64-bit
> atomicity, like it does on 32-bit ARM, but that's apparently not the case
> and looking at the 32-bit x86 pgtable code they have to be really careful
> there.

They added CMPXCHG8B for PAE, but then we never used it for that because
it's dead slow (MS did use it I think). Instead we play horrible split
word games, grep for CONFIG_GUP_GET_PTE_LOW_HIGH.
