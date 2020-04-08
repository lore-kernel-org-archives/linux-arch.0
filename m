From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Date: Wed, 8 Apr 2020 20:19:47 +0000
Message-ID: <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
 <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm6nam12on2121.outbound.protection.outlook.com ([40.107.243.121]:35425
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgDHUTv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 16:19:51 -0400
In-Reply-To: <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "ltykernel@gmail.com" <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <liuwe@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, vkuznets <vkuznets@redhat.com>

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, April 6, 2020 8:5=
4 AM
>=20
> When oops happens with panic_on_oops unset, the oops
> thread is killed by die() and system continues to run.
> In such case, guest should not report crash register
> data to host since system still runs. Check panic_on_oops
> and return directly in hyperv_report_panic() when the function
> is called in the die() and panic_on_oops is unset. Fix it.
>=20
> Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more=
 useful")
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v3:
> 	- Fix compile error.
>         - Add fix commit in the change log
> ---
>  arch/x86/hyperv/hv_init.c      | 6 +++++-
>  drivers/hv/vmbus_drv.c         | 5 +++--
>  include/asm-generic/mshyperv.h | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
