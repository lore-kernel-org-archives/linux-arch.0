From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 1/4] asm-generic/barrier: add generic nospec helpers
Date: Fri, 5 Jan 2018 09:15:29 +0000
Message-ID: <20180105091529.b7jip2q4a44esmh4@salmiak>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <20180103223827.39601-2-mark.rutland@arm.com>
 <20180104120021.lilczus6qv7e4vcw@salmiak>
 <CAA9_cmcWHc_068kHEDQ2DNcTZNFBAypmkhznnVODKccnuLFFOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42210 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbeAEJPg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jan 2018 04:15:36 -0500
Content-Disposition: inline
In-Reply-To: <CAA9_cmcWHc_068kHEDQ2DNcTZNFBAypmkhznnVODKccnuLFFOg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jan 04, 2018 at 08:21:56PM -0800, Dan Williams wrote:
> On Thu, Jan 4, 2018 at 4:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jan 03, 2018 at 10:38:24PM +0000, Mark Rutland wrote:
> >> +#define nospec_array_load(arr, idx, sz)                                      \
> >> +({                                                                   \
> >> +     typeof(*(arr)) *__arr = arr;                                    \
> >> +     typeof(idx) __idx = idx;                                        \
> >> +     typeof(sz) __sz = __sz;                                         \
> >
> > Whoops. The second __sz should be sz here.
> 
> Those should all have parenthesis on the args too, right?

Probably, yes.

I've added those to the version in my core/nospec branch.

Thanks,
Mark.
