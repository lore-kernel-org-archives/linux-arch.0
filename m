From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 2/2] clocksource/Hyper-V:  Add Hyper-V specific sched
 clock function
Date: Mon, 12 Aug 2019 18:41:38 +0000
Message-ID: <DM5PR21MB01371937B0E72671C4B7C990D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <20190729075243.22745-3-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729075243.22745-3-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>"ashal@kernel.org" <ashal@kernel.org>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>  Sent: Monday, July 29, 2019 12=
:53 AM
>=20
> Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_=
clock
> on x86.  But native_sched_clock() directly uses the raw TSC value, which
> can be discontinuous in a Hyper-V VM. Add the generic hv_setup_sched_cloc=
k()
> to set the sched clock function appropriately. On x86, this sets pv_ops.t=
ime.
> sched_clock to read the Hyper-V reference TSC value that is scaled and ad=
justed
> to be continuous.
>=20
> Also move the Hyper-V reference TSC initialization much earlier in the bo=
ot
> process so no discontinuity is observed when pv_ops.time.sched_clock
> calculates its offset.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          |  2 --
>  arch/x86/kernel/cpu/mshyperv.c     |  8 ++++++++
>  drivers/clocksource/hyperv_timer.c | 22 ++++++++++++----------
>  include/asm-generic/mshyperv.h     |  1 +
>  4 files changed, 21 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
