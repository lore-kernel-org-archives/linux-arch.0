Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36957 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932371AbeF0Kkq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jun 2018 06:40:46 -0400
Date: Wed, 27 Jun 2018 12:40:44 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: why do we still need bootmem allocator?
Message-ID: <20180627104044.GJ32348@dhcp22.suse.cz>
References: <20180625140754.GB29102@dhcp22.suse.cz>
 <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
 <20180627101144.GC4291@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627101144.GC4291@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Rob Herring <robh@kernel.org>, linux-mm@kvack.org, hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180627104044.sPxhuUetAowscypKb2toktoE7Gp162Ph2_4Lb4_oz70@z>

On Wed 27-06-18 13:11:44, Mike Rapoport wrote:
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

Cool!

> That leaves m68k and ia64

I will not get to those anytime soon (say a week or two) but I have that
close on top of my todo list.
-- 
Michal Hocko
SUSE Labs
