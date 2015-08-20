From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period" for
 future use with interrupts
Date: Thu, 20 Aug 2015 11:25:10 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE6465784913@DE02WEMBXB.internal.synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
 <20150818175527.GN20948@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:49008 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbbHTLZP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2015 07:25:15 -0400
In-Reply-To: <20150818175527.GN20948@worktop>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Peter,

> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: 18 =C1=D7=C7=D5=D3=D4=C1 2015 =C7. 20:55
> To: Alexey Brodkin
> Cc: linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org; Vineet.=
Gupta1@synopsys.com; arc-linux-dev@synopsys.com;
> arnd@arndb.de; Arnaldo Carvalho de Melo
> Subject: Re: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period"=
 for future use with interrupts
>=20
> On Wed, Aug 05, 2015 at 06:13:29PM +0300, Alexey Brodkin wrote:
> > +static int arc_pmu_event_set_period(struct perf_event *event)
> > +{
> > +	struct hw_perf_event *hwc =3D &event->hw;
> > +	s64 left =3D local64_read(&hwc->period_left);
> > +	s64 period =3D hwc->sample_period;
> > +	int idx =3D hwc->idx;
> > +	int overflow =3D 0;
> > +	u64 value;
> > +
> > +	if (unlikely(left <=3D -period)) {
> > +		/* left underflowed by more than period. */
> > +		left =3D period;
> > +		local64_set(&hwc->period_left, left);
> > +		hwc->last_period =3D period;
> > +		overflow =3D 1;
> > +	} else	if (unlikely(left <=3D 0)) {
> > +		/* left underflowed by less than period. */
> > +		left +=3D period;
> > +		local64_set(&hwc->period_left, left);
> > +		hwc->last_period =3D period;
> > +		overflow =3D 1;
> > +	}
> > +
> > +	if (left > arc_pmu->max_period) {
> > +		left =3D arc_pmu->max_period;
> > +		local64_set(&hwc->period_left, left);
>=20
> Given that you set counter_size to 32+bct_bcr.s << 4, I'm assuming th=
ese
> counters are not 64bit wide (or at least the hardware has the option =
of
> not being full width).

Indeed our counters could be 32/48(default)/64 bits wide.
=20
> That means this local64_set() is wrong.

You mean the one used for setting "hwc->period_left"?

> The purpose here is to emulate a longer period with a short counter. =
So
> even though we have to take the interrupt to observe the counter widt=
h
> overflow and reprogram, we must not decrease the @left value.
>=20
> Doing so will trigger one of the above two cases and result in @overf=
low
> =3D=3D 1, even though we've not actually had hwc->sample_period count=
s.

My understanding was that here we're just checking if for some reason i=
n
arc_perf_event_update() we decremented "hwc->period_left" too much
and it became either just <0 or even <(0 - period). IMHO that may happe=
n
if not in sampling even case (where we expect interrupt to happen close
to a period being crossed) but in case of non-sampling event IMHO that
is pretty possible if frequency of checking counter value is way too lo=
w.

-Alexey
