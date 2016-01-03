From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: smp_read_barrier_depends() for Blackfin
Date: Sun, 3 Jan 2016 10:08:30 -0800
Message-ID: <20160103180830.GA32217@linux.vnet.ibm.com>
References: <20160103162539.GB4172@localhost>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160103162539.GB4172@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Petko Manolov <petkan@mip-labs.com>
Cc: mingo@kernel.org, realmz6@gmail.com, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 03, 2016 at 06:25:39PM +0200, Petko Manolov wrote:
>  Content preview:  Hi Paul, Ingo, It seems to me that smp_read_barrier_depends
>     (which resolves to ___raw_smp_check_barrier_asm) is overdoing it, unless
>    that particular part it is written for is a disaster in terms of cache coherency.
>     [...] 
> 
>  Content analysis details:   (-1.0 points, 5.0 required)
> 
>   pts rule name              description
>  ---- ---------------------- --------------------------------------------------
>  -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
> X-ZLA-Header: unknown; 0
> X-ZLA-DetailInfo: BA=6.00004041; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000; ZH=6.00000000; ZP=6.00000000; ZU=6.00000002; UDB=6.00287883; UTC=2016-01-03 16:24:57
> x-cbid: 16010316-2214-0000-0000-00000F04BD9C
> X-IBM-ISS-SpamDetectors: Score=0.415652; FLB=0; FLI=0; BY=0.280117; FL=0;
>  FP=0; FZ=0; HX=0; KW=0; PH=0; RB=0; SC=0.415652; ST=0; TS=0; UL=0; ISC=
> X-IBM-ISS-DetailInfo:  BY=3.00004748; HX=3.00000237; KW=3.00000007;
>  PH=3.00000004; SC=3.00000129; SDB=6.00639970; UDB=6.00287883; UTC=2016-01-03
>  16:25:07
> X-TM-AS-MML: disable
> 
> 	Hi Paul, Ingo,
> 
> It seems to me that smp_read_barrier_depends (which resolves to 
> ___raw_smp_check_barrier_asm) is overdoing it, unless that particular part it is 
> written for is a disaster in terms of cache coherency.
> 
> So far this is the only architecture that i know of (baring Alpha) which employs 
> non-empty read_barrier_depends().  I am wondering if this is really needed or 
> those who did the arch port got overly enthusiastic.  If it is the former then 
> you may include another example of crazy architecture in your book. :)

Hello, Petko,

I must defer to the architecture maintainers.  That said, there was a time
when the blackfin maintainer were trying to make an SMP system without
cache coherence, that is, by simply wiring two UP-only blackfin CPUs
into a single system.  They were using cache-flush tricks to make things
more-or-less work.  And their ___raw_smp_check_barrier_asm() does look
to be flushing caches, so maybe that is what is happening here.  And the
comment header for read_barrier_depends() seems to support this view.

Adding the blackfin folks and the usual lists on CC.  Might get
us something better than my half-remembered hearsay and possible
misinterpretations of header comments.  ;-)

That said, cache-incoherent systems might well be a good addition to
the book.

							Thanx, Paul
