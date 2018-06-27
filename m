From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: why do we still need bootmem allocator?
Date: Wed, 27 Jun 2018 18:58:12 +0300
Message-ID: <20180627155811.GA19182@rapoport-lnx>
References: <20180625140754.GB29102@dhcp22.suse.cz>
 <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
 <20180627101144.GC4291@rapoport-lnx>
 <CAL_Jsq+evsgh9Qi6FfG4vUZWtpC0UrFjTWSrzukMxY==TD_mrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+evsgh9Qi6FfG4vUZWtpC0UrFjTWSrzukMxY==TD_mrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mhocko@kernel.org, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 27, 2018 at 07:58:19AM -0600, Rob Herring wrote:
> On Wed, Jun 27, 2018 at 4:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > On Mon, Jun 25, 2018 at 10:09:41AM -0600, Rob Herring wrote:
> > > On Mon, Jun 25, 2018 at 8:08 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > Hi,
> > > > I am wondering why do we still keep mm/bootmem.c when most architectures
> > > > already moved to nobootmem. Is there any fundamental reason why others
> > > > cannot or this is just a matter of work?
> > >
> > > Just because no one has done the work. I did a couple of arches
> > > recently (sh, microblaze, and h8300) mainly because I broke them with
> > > some DT changes.
> >
> > I have a patch for alpha nearly ready.
> > That leaves m68k and ia64
> 
> And c6x, hexagon, mips, nios2, unicore32. Those are all the platforms
> which don't select NO_BOOTMEM.

Yeah, you are right. I've somehow excluded those that HAVE_MEMBLOCK...
 
> Rob
> 

-- 
Sincerely yours,
Mike.
