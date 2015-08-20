From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH v2 4/8] ARCv2: perf: Support sampling events using
 overflow interrupts
Date: Thu, 20 Aug 2015 11:30:33 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE6465784946@DE02WEMBXB.internal.synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-5-git-send-email-abrodkin@synopsys.com>
 <20150818221215.GO20948@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:49094 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbbHTLag convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2015 07:30:36 -0400
In-Reply-To: <20150818221215.GO20948@worktop>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Peter,

> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: 19 =C1=D7=C7=D5=D3=D4=C1 2015 =C7. 1:12
> To: Alexey Brodkin
> Cc: linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org; Vineet.=
Gupta1@synopsys.com; arc-linux-dev@synopsys.com;
> arnd@arndb.de; Arnaldo Carvalho de Melo
> Subject: Re: [PATCH v2 4/8] ARCv2: perf: Support sampling events usin=
g overflow interrupts
>=20
> On Wed, Aug 05, 2015 at 06:13:30PM +0300, Alexey Brodkin wrote:
> > @@ -319,6 +336,20 @@ static int arc_pmu_add(struct perf_event *even=
t, int flags)
> >  	}
> >
> >  	write_aux_reg(ARC_REG_PCT_INDEX, idx);
> > +
> > +	arc_pmu->act_counter[idx] =3D event;
> > +
> > +	if (is_sampling_event(event)) {
> > +		/* Mimic full counter overflow as other arches do */
> > +		write_aux_reg(ARC_REG_PCT_INT_CNTL, (u32)arc_pmu->max_period);
> > +		write_aux_reg(ARC_REG_PCT_INT_CNTH,
> > +			      (arc_pmu->max_period >> 32));
> > +
> > +		/* Enable interrupt for this counter */
> > +		write_aux_reg(ARC_REG_PCT_INT_CTRL,
> > +			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
> > +	}
>=20
> *confused* pmu::add should only start on flags & PERF_EF_START, and t=
hen
> we start with hwc->sample_period, not the max_period.

Did you mean here that we should enable interrupts in arc_pmu_start() b=
ut not
in arc_pmu_add()?

-Alexey
