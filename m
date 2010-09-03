From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select m68knommu
 contributions
Date: Fri, 3 Sep 2010 13:30:29 +1000
Message-ID: <4C806BD5.2090000@snapgear.com>
References: <19747.1283422807@redhat.com>	<20100902102158.19806.14133.stgit@warthog.procyon.org.uk>	<m38w3kns4r.fsf@hase.home> <AANLkTikwax-Jb60jT5_TOL=Zkwbgh8FwMk78ncm1dN-P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikwax-Jb60jT5_TOL=Zkwbgh8FwMk78ncm1dN-P@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@redhat.com>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Geert Uytterhoeven wrote:
> On Thu, Sep 2, 2010 at 16:21, Andreas Schwab <schwab@redhat.com> wrote:
>> David Howells <dhowells@redhat.com> writes:
>>
>>> Use CONFIG_MMU not __uClinux__ to select m68knommu contributions as nothing in
>>> the arch defines __uClinux__ for the build.
>> You are using the wrong compiler.
> 
> it would be nice if you could use the same compiler for m68k and m68knommu, at
> least for compiling kernels.

It would be very nice :-)

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
