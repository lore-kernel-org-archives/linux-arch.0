From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFCv2 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Fri, 5 Jan 2018 16:48:00 +0000
Message-ID: <20180105164800.jyx6dwbs5uryaf5z@lakrids.cambridge.arm.com>
References: <20180105145750.53294-1-mark.rutland@arm.com>
 <20180105145750.53294-5-mark.rutland@arm.com>
 <CAPcyv4hUAzCxH4sQAJgocFZ4RN2s6P_6+PO5xqYXU5R+O=coUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeAEQsO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jan 2018 11:48:14 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4hUAzCxH4sQAJgocFZ4RN2s6P_6+PO5xqYXU5R+O=coUQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Elena Reshetova <elena.reshetova@intel.com>, Jonathan Corbet <corbet@lwn.net>, Alan Cox <alan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jan 05, 2018 at 08:38:43AM -0800, Dan Williams wrote:
> On Fri, Jan 5, 2018 at 6:57 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Note: this patch is an *example* use of the nospec API. It is understood
> > that this is incomplete, etc.
> >
> > Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> > memory accesses under a bounds check may be speculated even if the
> > bounds check fails, providing a primitive for building a side channel.
> >
> > The EBPF map code has a number of such bounds-checks accesses in
> > map_lookup_elem implementations. This patch modifies these to use the
> > nospec helpers to inhibit such side channels.
> >
> > The JITted lookup_elem implementations remain potentially vulnerable,
> > and are disabled (with JITted code falling back to the C
> > implementations).
> 
> Do we still need this given this patch from the bpf folks:
> 
>     https://patchwork.ozlabs.org/patch/855911/

Probably not; it was jsut easier to update this example than to write
new ones.

I've started on the set of cases Elena reported. Most cases fall out
quite nicely, though in places where there's a lot of pointer
arithmetic it's somewhat more painful. I'll try to use those in future,
unless someone beats me to implementing them. ;)

Thanks,
Mark.
