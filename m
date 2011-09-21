From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 43/57] PNP: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 14:20:46 -0600
Message-ID: <CAErSpo7VR8+AGgWABb2c0uU_bgcmg43dxui41JFzmCQPvC7bGg@mail.gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com> <1316597339-29861-44-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:49709 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1IUUVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2011 16:21:10 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p8LKL9bd019721
	for <linux-arch@vger.kernel.org>; Wed, 21 Sep 2011 13:21:09 -0700
Received: from gwaa12 (gwaa12.prod.google.com [10.200.27.12])
	by wpaz13.hot.corp.google.com with ESMTP id p8LKKnHh008397
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 21 Sep 2011 13:21:08 -0700
Received: by gwaa12 with SMTP id a12so2416208gwa.14
        for <linux-arch@vger.kernel.org>; Wed, 21 Sep 2011 13:21:08 -0700 (PDT)
In-Reply-To: <1316597339-29861-44-git-send-email-yong.zhang0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Adam Belay <abelay@mit.edu>

On Wed, Sep 21, 2011 at 3:28 AM, Yong Zhang <yong.zhang0@gmail.com> wro=
te:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disa=
bled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
>
> So now this flag is a NOOP and can be removed.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> =A0drivers/pnp/resource.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
> index b0ecacb..3669821 100644
> --- a/drivers/pnp/resource.c
> +++ b/drivers/pnp/resource.c
> @@ -385,7 +385,7 @@ int pnp_check_irq(struct pnp_dev *dev, struct res=
ource *res)
> =A0 =A0 =A0 =A0 * device is active because it itself may be in use */
> =A0 =A0 =A0 =A0if (!dev->active) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (request_irq(*irq, pnp_test_handler=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DI=
SABLED | IRQF_PROBE_SHARED, "pnp", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_PR=
OBE_SHARED, "pnp", NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(*irq, NULL);
> =A0 =A0 =A0 =A0}
> --
> 1.7.4.1
>
>
