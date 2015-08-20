From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH v2 6/8] ARCv2: perf: implement exclusion of event
 counting in user or kernel mode
Date: Thu, 20 Aug 2015 11:33:54 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE6465784970@DE02WEMBXB.internal.synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-7-git-send-email-abrodkin@synopsys.com>
 <20150818233713.GP20948@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:49158 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbHTLd7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2015 07:33:59 -0400
In-Reply-To: <20150818233713.GP20948@worktop>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Peter,

> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: 19 =C1=D7=C7=D5=D3=D4=C1 2015 =C7. 2:37
> To: Alexey Brodkin
> Cc: linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org; Vineet.=
Gupta1@synopsys.com; arc-linux-dev@synopsys.com;
> arnd@arndb.de; Arnaldo Carvalho de Melo
> Subject: Re: [PATCH v2 6/8] ARCv2: perf: implement exclusion of event=
 counting in user or kernel mode
>=20
> On Wed, Aug 05, 2015 at 06:13:32PM +0300, Alexey Brodkin wrote:
> > +	hwc->config =3D 0;
> > +
> > +	if (is_isa_arcv2()) {
> > +		/* "exclude user" means "count only kernel" */
> > +		if (event->attr.exclude_user)
> > +			hwc->config |=3D ARC_REG_PCT_CONFIG_KERN;
> > +
> > +		/* "exclude kernel" means "count only user" */
> > +		if (event->attr.exclude_kernel)
> > +			hwc->config |=3D ARC_REG_PCT_CONFIG_USER;
> > +	}
> > +
> >  	switch (event->attr.type) {
> >  	case PERF_TYPE_HARDWARE:
> >  		if (event->attr.config >=3D PERF_COUNT_HW_MAX)
> >  			return -ENOENT;
> >  		if (arc_pmu->ev_hw_idx[event->attr.config] < 0)
> >  			return -ENOENT;
> > -		hwc->config =3D arc_pmu->ev_hw_idx[event->attr.config];
> > +		hwc->config |=3D arc_pmu->ev_hw_idx[event->attr.config];
>=20
> So I would still very much like perf_event_attr::config to reflect th=
e
> value you'll program into hardware.
>=20
> If you want to do that weird 4 character lookup thing, use a special
> hardware event (possibly 0 if that is not a valid value), and stuff t=
he
> 4 chars in ::config1

Ok I understand your concern here but I cannot quite understand
what do you mean saying "stuff the 4 chars in ::config1".

Could you please explain this a bit more verbose?
Is there an example of something similar I may take a look at?

-Alexey
