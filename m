From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period" for
 future use with interrupts
Date: Thu, 20 Aug 2015 10:46:56 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE64657848C6@DE02WEMBXB.internal.synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
 <20150818175203.GM20948@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:40515 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbbHTKrP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2015 06:47:15 -0400
In-Reply-To: <20150818175203.GM20948@worktop>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Peter,

> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: 18 =C1=D7=C7=D5=D3=D4=C1 2015 =C7. 20:52
> To: Alexey Brodkin
> Cc: linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org; Vineet.=
Gupta1@synopsys.com; arc-linux-dev@synopsys.com;
> arnd@arndb.de; Arnaldo Carvalho de Melo
> Subject: Re: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period"=
 for future use with interrupts
>=20
> On Wed, Aug 05, 2015 at 06:13:29PM +0300, Alexey Brodkin wrote:
> > Even though this hardware implementation allows for more flexibilit=
y,
> > in Linux kernel we decided to mimic behavior of other architectures=
 this
> > way:
> >
> >  [1] Set limit value as half of counter's max value (to allow count=
er to
> >      run after reaching it limit, see below for more explanation):
> >  ---------->8-----------
> >  arc_pmu->max_period =3D (1ULL << counter_size) / 2 - 1ULL;
> >  ---------->8-----------
>=20
> > @@ -317,10 +365,11 @@ static int arc_pmu_device_probe(struct platfo=
rm_device *pdev)
> >  		return -ENOMEM;
> >
> >  	arc_pmu->n_counters =3D pct_bcr.c;
> > -	arc_pmu->counter_size =3D 32 + (pct_bcr.s << 4);
> > +	counter_size =3D 32 + (pct_bcr.s << 4);
> > +	arc_pmu->max_period =3D (1ULL << counter_size) - 1ULL;
> >
>=20
> I don't see that /2 there..

Probably another good solution for that coupl be merging of 2 following=
 patches in one:
 [1]  [PATCH v2 3/8] ARCv2: perf: implement "event_set_period" for futu=
re use with interrupts
 [2] [PATCH v2 5/8] ARCv2: perf: set usable max period as a half of rea=
l max period

And then comment will become valid.

-Alexey
