From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Date: Thu, 9 Apr 2020 23:06:13 +0000
Message-ID: <MW2PR2101MB10525BA673D7FA81073B9F65D7C10@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
 <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200409164054.72es2ykmbef3jbui@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr690105.outbound.protection.outlook.com ([40.107.69.105]:53634
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgDIXGQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Apr 2020 19:06:16 -0400
In-Reply-To: <20200409164054.72es2ykmbef3jbui@debian>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: "ltykernel@gmail.com" <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <liuwe@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, vkuznets <vkuznets@redhat.com>

From: Wei Liu <wei.liu@kernel.org>  Sent: Thursday, April 9, 2020 9:41 AM
>=20
> On Wed, Apr 08, 2020 at 08:19:47PM +0000, Michael Kelley wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, April 6, 2020=
 8:54 AM
> > >
> > > When oops happens with panic_on_oops unset, the oops
> > > thread is killed by die() and system continues to run.
> > > In such case, guest should not report crash register
> > > data to host since system still runs. Check panic_on_oops
> > > and return directly in hyperv_report_panic() when the function
> > > is called in the die() and panic_on_oops is unset. Fix it.
> > >
> > > Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be =
more useful")
> > > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > > ---
> > > Change since v3:
> > > 	- Fix compile error.
> > >         - Add fix commit in the change log
> > > ---
> > >  arch/x86/hyperv/hv_init.c      | 6 +++++-
> > >  drivers/hv/vmbus_drv.c         | 5 +++--
> > >  include/asm-generic/mshyperv.h | 2 +-
> > >  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> It seems to me only the last patch is new, others are already in my
> tree, so I only apply the last one.
>=20
> Let me know if my understanding is wrong.
>=20

Tianyu added "Fixes:" tags to some of the other patches in
the series.  It appears the version you had already queued doesn't
have those "Fixes:" tags.

Michael
