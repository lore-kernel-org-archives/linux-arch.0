Return-Path: <SRS0=yGje=5Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgDIQk7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 12:40:59 -0400
Date: Thu, 9 Apr 2020 17:40:54 +0100
From: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Message-ID: <20200409164054.72es2ykmbef3jbui@debian>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
 <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: "ltykernel@gmail.com" <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <liuwe@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, vkuznets <vkuznets@redhat.com>, Wei Liu <wei.liu@kernel.org>
Message-ID: <20200409164054.xQYG4zcGeupPHbtkRSv4ITx359Ia4Rnv5nDQOv40K8I@z>

On Wed, Apr 08, 2020 at 08:19:47PM +0000, Michael Kelley wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, April 6, 2020 8:54 AM
> > 
> > When oops happens with panic_on_oops unset, the oops
> > thread is killed by die() and system continues to run.
> > In such case, guest should not report crash register
> > data to host since system still runs. Check panic_on_oops
> > and return directly in hyperv_report_panic() when the function
> > is called in the die() and panic_on_oops is unset. Fix it.
> > 
> > Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more useful")
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> > Change since v3:
> > 	- Fix compile error.
> >         - Add fix commit in the change log
> > ---
> >  arch/x86/hyperv/hv_init.c      | 6 +++++-
> >  drivers/hv/vmbus_drv.c         | 5 +++--
> >  include/asm-generic/mshyperv.h | 2 +-
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

It seems to me only the last patch is new, others are already in my
tree, so I only apply the last one.

Let me know if my understanding is wrong.

Wei.
