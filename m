Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756324Ab1LGOgm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Dec 2011 09:36:42 -0500
Message-ID: <4EDF79DF.6050209@redhat.com>
Date: Wed, 07 Dec 2011 16:36:15 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5 V5] Add generic stubs for kvm stop check functions
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <1323116344-17911-5-git-send-email-emunson@mgebm.net>
In-Reply-To: <1323116344-17911-5-git-send-email-emunson@mgebm.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20111207143615.qLWSr-qY4yb2_LwY65IF4yZhPGQPEwsTACDqRxBXPRM@z>

On 12/05/2011 10:19 PM, Eric B Munson wrote:
>
> diff --git a/include/asm-generic/kvm_para.h b/include/asm-generic/kvm_para.h
> new file mode 100644
> index 0000000..177e1eb
> --- /dev/null
> +++ b/include/asm-generic/kvm_para.h
> @@ -0,0 +1,14 @@
> +#ifndef _ASM_GENERIC_KVM_PARA_H
> +#define _ASM_GENERIC_KVM_PARA_H
> +
> +
> +/*
> + * This function is used by architectures that support kvm to avoid issuing
> + * false soft lockup messages.
> + */
> +static inline bool kvm_check_and_clear_guest_paused(int cpu)
> +{
> +	return false;
> +}
> +
> +#endif

Please fold into patch 2.

What about arch/{ia64,s390,powerpc}/include/asm/kvm_para.h?

-- 
error compiling committee.c: too many arguments to function

