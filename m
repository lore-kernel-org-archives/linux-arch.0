Return-Path: <SRS0=fIL7=27=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:54524 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgAJSB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 13:01:26 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id BB9A31813CB82
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 17:54:32 +0000 (UTC)
Message-ID: <8fe4f81699517758b44afbe0e1a53bc080f64a62.camel@perches.com>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
From: Joe Perches <joe@perches.com>
Date: Fri, 10 Jan 2020 09:53:36 -0800
In-Reply-To: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org>
         <20200110165636.28035-2-will@kernel.org>
         <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20200110175336.JvQ6_M3Jqlkk2gy5gC2Cu2RQnbHHEVSKt22TIWRQtpE@z>

On Fri, 2020-01-10 at 18:35 +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > discarding the 'volatile' qualifier:
> > 
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > 
> > We've been working around this using some nasty hacks which make
> > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > kernel builds now, emit a warning if we detect it during the build.
> 
> No objection to recommending gcc-4.8, but I think this should either
> just warn once during the kernel build instead of for every file, or
> it should become a hard requirement.

It might as well be a hard requirement as
gcc 4.8.0 is already nearly 7 years old.

gcc 4.6.0 released 2011-03-25
gcc 4.8.0 released 2013-03-22

Perhaps there are exceedingly few to zero new
instances using gcc compiler versions < 4.8
