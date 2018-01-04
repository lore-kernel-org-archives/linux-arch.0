From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 05:50:12 +0000
Message-ID: <20180104055012.GD21978@ZenIV.linux.org.uk>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
 <1515035438.20588.4.camel@intel.com>
 <20180104044424.GC21978@ZenIV.linux.org.uk>
 <CAPcyv4gKQD68dCCD-Nz78ZQ9ttung5yMzG3f+JRmGUxuKhK4Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51324 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbeADFuR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 00:50:17 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4gKQD68dCCD-Nz78ZQ9ttung5yMzG3f+JRmGUxuKhK4Pw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wed, Jan 03, 2018 at 09:44:33PM -0800, Dan Williams wrote:
> On Wed, Jan 3, 2018 at 8:44 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Thu, Jan 04, 2018 at 03:10:51AM +0000, Williams, Dan J wrote:
> >
> >> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> >> index 1c65817673db..dbc12007da51 100644
> >> --- a/include/linux/fdtable.h
> >> +++ b/include/linux/fdtable.h
> >> @@ -82,8 +82,10 @@ static inline struct file *__fcheck_files(struct files_struct *files, unsigned i
> >>  {
> >>       struct fdtable *fdt = rcu_dereference_raw(files->fdt);
> >>
> >> -     if (fd < fdt->max_fds)
> >> +     if (fd < fdt->max_fds) {
> >> +             osb();
> >>               return rcu_dereference_raw(fdt->fd[fd]);
> >> +     }
> >>       return NULL;
> >>  }
> >
> > ... and the point of that would be?  Possibly revealing the value of files->fdt?
> > Why would that be a threat, assuming you manage to extract the information in
> > question in the first place?
> 
> No, the concern is that an fd value >= fdt->max_fds may cause the cpu
> to read arbitrary memory addresses relative to files->fdt and
> userspace can observe that it got loaded.

Yes.  And all that might reveal is the value of files->fdt.  Who cares?
