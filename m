Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754546AbeF0N6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jun 2018 09:58:31 -0400
MIME-Version: 1.0
References: <20180625140754.GB29102@dhcp22.suse.cz> <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
 <20180627101144.GC4291@rapoport-lnx>
In-Reply-To: <20180627101144.GC4291@rapoport-lnx>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Jun 2018 07:58:19 -0600
Message-ID: <CAL_Jsq+evsgh9Qi6FfG4vUZWtpC0UrFjTWSrzukMxY==TD_mrg@mail.gmail.com>
Subject: Re: why do we still need bootmem allocator?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rppt@linux.vnet.ibm.com
Cc: mhocko@kernel.org, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20180627135819.f24blPikO3ZLvr5q-9YR_Wlm_DrnYmOALZxf5xtexEE@z>

On Wed, Jun 27, 2018 at 4:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> On Mon, Jun 25, 2018 at 10:09:41AM -0600, Rob Herring wrote:
> > On Mon, Jun 25, 2018 at 8:08 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > Hi,
> > > I am wondering why do we still keep mm/bootmem.c when most architectures
> > > already moved to nobootmem. Is there any fundamental reason why others
> > > cannot or this is just a matter of work?
> >
> > Just because no one has done the work. I did a couple of arches
> > recently (sh, microblaze, and h8300) mainly because I broke them with
> > some DT changes.
>
> I have a patch for alpha nearly ready.
> That leaves m68k and ia64

And c6x, hexagon, mips, nios2, unicore32. Those are all the platforms
which don't select NO_BOOTMEM.

Rob
