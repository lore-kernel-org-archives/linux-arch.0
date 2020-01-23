From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Thu, 23 Jan 2020 17:16:41 +0000
Message-ID: <20200123171641.GC20126@willie-the-truck>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgAWRQr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 12:16:47 -0500
Content-Disposition: inline
In-Reply-To: <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Thu, Jan 23, 2020 at 05:07:40PM +0000, David Laight wrote:
> From: Will Deacon
> > Sent: 23 January 2020 15:34
> ...
> >   * Only warn once at build-time if GCC prior to 4.8 is detected...
> > 
> >   * ... and then raise the minimum GCC version to 4.8, with an error for
> >     older versions of the compiler
> 
> If the kernel compiled with gcc 4.7 is likely to be buggy, don't these
> need to be in the other order?
> 
> Otherwise you need to keep the old versions for use with the old
> compilers.

I think it depends how much we care about those older compilers. My series
first moves it to "Good luck mate, you're on your own" and then follows up
with a "Let me take that off you it's sharp".

Will
