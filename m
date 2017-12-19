Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.187]:64488 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966109AbdLSMrS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Dec 2017 07:47:18 -0500
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 0/2] mm: introduce MAP_FIXED_SAFE
Date: Tue, 19 Dec 2017 12:40:16 +0000
Message-ID: <0ca2620ce7534c5491e69416621ac41b@AcuMS.aculab.com>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213163210.6a16ccf8753b74a6982ef5b6@linux-foundation.org>
 <CAFLM3-oANXKEU=tuurSJx9rdzfWGfym-0FUEWnfBq8mOaVMzOA@mail.gmail.com>
 <20171214131526.GM16951@dhcp22.suse.cz> <20171214145443.GA2202@brick>
In-Reply-To: <20171214145443.GA2202@brick>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Edward Napierala' <trasz@freebsd.org>, Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Kees Cook <keescook@chromium.org>, "jasone@google.com" <jasone@google.com>, "davidtgoldblatt@gmail.com" <davidtgoldblatt@gmail.com>
Message-ID: <20171219124016.MeZzf44nUNDBs9X3v31fAmmvTgM9UbToHkRx-ivH6Wg@z>

From: Edward Napierala
> Sent: 14 December 2017 14:55
>
> On 1214T1415, Michal Hocko wrote:
> > On Thu 14-12-17 12:44:17, Edward Napierala wrote:
> > > Regarding the name - how about adopting MAP_EXCL?  It was introduced in
> > > FreeBSD,
> > > and seems to do exactly this; quoting mmap(2):
> > >
> > > MAP_FIXED    Do not permit the system to select a different address
> > >                         than the one specified.  If the specified address
> > >                         cannot be used, mmap() will fail.  If MAP_FIXED is
> > >                         specified, addr must be a multiple of the page size.
> > >                         If MAP_EXCL is not specified, a successful MAP_FIXED
> > >                         request replaces any previous mappings for the
> > >                         process' pages in the range from addr to addr + len.
> > >                         In contrast, if MAP_EXCL is specified, the request
> > >                         will fail if a mapping already exists within the
> > >                         range.
> >
> > I am not familiar with the FreeBSD implementation but from the above it
> > looks like MAP_EXCL is a MAP_FIXED mofifier which is not how we are
> > going to implement it in linux due to reasons mentioned in this cover
> > letter. Using the same name would be more confusing than helpful I am
> > afraid.
> 
> Sorry, missed that.  Indeed, reusing a name with a different semantics
> would be a bad idea.

I don't remember any discussion about using MAP_FIXED | MAP_EXCL ?

Why not match the prior art??

	David
