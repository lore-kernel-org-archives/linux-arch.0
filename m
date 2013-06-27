From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] arch: s390: kernel: scan all present cpu forcely.
Date: Thu, 27 Jun 2013 10:18:45 +0200
Message-ID: <20130627081845.GA3824@osiris>
References: <51C8F685.6000209@asianux.com>
 <20130625064832.GA4999@osiris>
 <51C94599.1020707@asianux.com>
 <20130625090928.GA8981@osiris>
 <51CBA6B6.1010809@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:38889 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab3F0ISv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 04:18:51 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 27 Jun 2013 09:16:24 +0100
Content-Disposition: inline
In-Reply-To: <51CBA6B6.1010809@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Thu, Jun 27, 2013 at 10:43:02AM +0800, Chen Gang wrote:
> The architectures which may support 'hotpluggable', can scan all cpus
> during subsys_initcall().  the upper caller will skip the return value.
> 
> It also can initialize hotpluggable flag of all cpus in time, no matter
> whether any cpus fail or not.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/s390/kernel/smp.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index d386c4e..75a118f 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -1064,8 +1064,9 @@ static int __init s390_smp_init(void)
>  #endif
>  	for_each_present_cpu(cpu) {
>  		rc = smp_add_present_cpu(cpu);
> -		if (rc)
> -			return rc;
> +		if (unlikely(rc))
> +			printk(KERN_WARNING "%s: add cpu %d failed (%d)\n",
> +			       __func__, cpu, rc);

I have no idea how the patch description is supposed to correlate with
your patch.
However your patch doesn't make sense anyway.
We have initcall_debug for .. initcall debugging, which your patch would
break in addition, since this function would now return 0 instead of the
return code.
