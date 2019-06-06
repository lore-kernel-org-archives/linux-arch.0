Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727539AbfFFJns (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2019 05:43:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x569bUvT181080
        for <linux-arch@vger.kernel.org>; Thu, 6 Jun 2019 05:43:46 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sxyqvjbnu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2019 05:43:45 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Jun 2019 10:43:44 +0100
Date: Thu, 6 Jun 2019 02:43:40 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Reply-To: paulmck@linux.ibm.com
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
 <20190603201324.GN28207@linux.ibm.com>
 <CAMuHMdW-8Jt80mSyHTYmj6354-3f1=Vp_8dY-Nite1ERpUCFew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW-8Jt80mSyHTYmj6354-3f1=Vp_8dY-Nite1ERpUCFew@mail.gmail.com>
Message-ID: <20190606094340.GD28207@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190606094340.h4to2huBZGrE3CX5Qnqlz_iT3GThW7OBzh4REpCJJ_M@z>

On Tue, Jun 04, 2019 at 09:41:04AM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Mon, Jun 3, 2019 at 10:14 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > On Mon, Jun 03, 2019 at 06:08:35PM +0000, Vineet Gupta wrote:
> > > On 5/31/19 1:21 AM, Peter Zijlstra wrote:
> > > >> I'm not sure how to interpret "natural alignment" for the case of double
> > > >> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> > > >> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> > > > Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))
> > > >
> > > > For any u64 type, that would give 8 byte alignment. the problem
> > > > otherwise being that your data spans two lines/pages etc..
> > >
> > > Sure, but as Paul said, if the software doesn't expect them to be atomic by
> > > default, they could span 2 hardware lines to keep the implementation simpler/sane.
> >
> > I could imagine 8-byte types being only four-byte aligned on 32-bit systems,
> > but it would be quite a surprise on 64-bit systems.
> 
> Or two-byte aligned?
> 
> M68k started with a 16-bit data bus, and alignment rules were retained
> when gaining a wider data bus.
> 
> BTW, do any platforms have issues with atomicity of 4-byte types on
> 16-bit data buses? I believe some embedded ARM or PowerPC do have
> such buses.

But m68k is !SMP-only, correct?  If so, the only issues would be
interactions with interrupt handlers and the like, and doesn't current
m68k hardware use exact interrupts?  Or is it still possible to interrupt
an m68k in the middle of an instruction like it was in the bad old days?

							Thanx, Paul

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
