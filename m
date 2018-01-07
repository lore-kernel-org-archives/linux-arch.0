From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFCv2 2/4] Documentation: document nospec helpers
Date: Sun, 7 Jan 2018 13:06:11 +0000
Message-ID: <20180107130610.3vllt5cm2b3orukd@salmiak>
References: <20180105145750.53294-1-mark.rutland@arm.com>
 <20180105145750.53294-3-mark.rutland@arm.com>
 <f7a88365-8936-0d5e-0764-8664429e6305@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753283AbeAGNGU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 7 Jan 2018 08:06:20 -0500
Content-Disposition: inline
In-Reply-To: <f7a88365-8936-0d5e-0764-8664429e6305@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dan.j.williams@intel.com, elena.reshetova@intel.com, corbet@lwn.net, alan@linux.intel.com, peterz@infradead.org, will.deacon@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de, Paul Turner <pjt@google.com>

On Sat, Jan 06, 2018 at 09:20:59PM -0800, Randy Dunlap wrote:
> On 01/05/18 06:57, Mark Rutland wrote:
> > Document the rationale and usage of the new nospec*() helpers.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  Documentation/speculation.txt | 166 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >  create mode 100644 Documentation/speculation.txt
> > 
> > diff --git a/Documentation/speculation.txt b/Documentation/speculation.txt
> > new file mode 100644
> > index 000000000000..748fcd4dcda4
> > --- /dev/null
> > +++ b/Documentation/speculation.txt
> > @@ -0,0 +1,166 @@
> > +
> > +Typically speculative execution cannot be observed from architectural state,
> > +such as the contents of registers. However, in some cases it is possible to
> > +observe its impact on microarchitectural state, such as the presence or
> > +absence of data in caches. Such state may form side-channels which can be
> > +observed to extract secret information.
> 
> I'm curious about what it takes to observe this...
> 
> or is that covered in the exploit papers?

That's covered elsewhere, e.g.

https://googleprojectzero.blogspot.co.uk/2018/01/reading-privileged-memory-with-side.html

I'll add some references.

Thanks,
Mark.
