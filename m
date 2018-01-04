From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 16:39:54 +0000
Message-ID: <20180104163759.5apqt6lnsfowudcl@salmiak>
References: <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
 <1515035438.20588.4.camel@intel.com>
 <87vagiusj1.fsf@xmission.com>
 <CAPcyv4hOtk3QsCWOhECs7=UCh-iO+TKSJvRmqVq+Xhjx9OTiew@mail.gmail.com>
 <87wp0xu12k.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34976 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753438AbeADQkJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 11:40:09 -0500
Content-Disposition: inline
In-Reply-To: <87wp0xu12k.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Thu, Jan 04, 2018 at 08:54:11AM -0600, Eric W. Biederman wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> > On Wed, Jan 3, 2018 at 9:01 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> "Williams, Dan J" <dan.j.williams@intel.com> writes:
> Either the patch you presented missed a whole lot like 90%+ of the
> user/kernel interface or there is some mitigating factor that I am not
> seeing.  Either way until reasonable people can read the code and
> agree on the potential exploitability of it, I will be nacking these
> patches.

As Dan mentioned, this is the result of auditing some static analysis reports.
I don't think it was claimed that this was complete, just that these are
locations that we're fairly certain need attention.

Auditing the entire user/kernel interface is going to take time, and I don't
think we should ignore this corpus in the mean time (though we certainly want
to avoid a whack-a-mole game).

[...]

> >>> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> >>> index 8ca9915befc8..7f83abdea255 100644
> >>> --- a/net/mpls/af_mpls.c
> >>> +++ b/net/mpls/af_mpls.c
> >>> @@ -81,6 +81,8 @@ static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
> >>>       if (index < net->mpls.platform_labels) {
> >>>               struct mpls_route __rcu **platform_label =
> >>>                       rcu_dereference(net->mpls.platform_label);
> >>> +
> >>> +             osb();
> >>>               rt = rcu_dereference(platform_label[index]);
> >>>       }
> >>>       return rt;
> >>
> >> Ouch!  This adds a barrier in the middle of an rcu lookup, on the
> >> fast path for routing mpls packets.  Which if memory serves will
> >> noticably slow down software processing of mpls packets.
> >>
> >> Why does osb() fall after the branch for validity?  So that we allow
> >> speculation up until then?
> >
> > It falls there so that the cpu only issues reads with known good 'index' values.
> >
> >> I suspect it would be better to have those barriers in the tun/tap
> >> interfaces where userspace can inject packets and thus time them.  Then
> >> the code could still speculate and go fast for remote packets.
> >>
> >> Or does the speculation stomping have to be immediately at the place
> >> where we use data from userspace to perform a table lookup?
> >
> > The speculation stomping barrier has to be between where we validate
> > the input and when we may speculate on invalid input.
> 
> So a serializing instruction at the kernel/user boundary (like say
> loading cr3) is not enough?  That would seem to break any chance of a
> controlled timing.

Unfortunately, it isn't sufficient to do this at the kernel/user boundary. Any
subsequent bounds check can be mis-speculated regardless of prior
serialization.

Such serialization has to occur *after* the relevant bounds check, but *before*
use of the value that was checked.

Where it's possible to audit user-provided values up front, we may be able to
batch checks to amortize the cost of such serialization, but typically bounds
checks are spread arbitrarily deep in the kernel.

[...]

> Given what I have seen in other parts of the thread I think an and
> instruction that just limits the index to a sane range is generally
> applicable, and should be cheap enough to not care about.

Where feasible, this sounds good to me.

However, since many places have dynamic bounds which aren't necessarily
powers-of-two, I'm not sure how applicable this is.

Thanks,
Mark.
