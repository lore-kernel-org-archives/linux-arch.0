From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 1/6 V2] Add flag to indicate that a vm was stopped by
 the host
Date: Tue, 01 Nov 2011 14:22:33 -0500
Message-ID: <4EB046F9.7060306@us.ibm.com>
References: <1320091650-24682-1-git-send-email-emunson@mgebm.net> <1320091650-24682-2-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:58153 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab1KATYb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Nov 2011 15:24:31 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aliguori@us.ibm.com>;
	Tue, 1 Nov 2011 13:23:43 -0600
In-Reply-To: <1320091650-24682-2-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, ryanh@linux.vnet.ibm.com, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

On 10/31/2011 03:07 PM, Eric B Munson wrote:
> This flag will be used to check if the vm was stopped by the host when a soft
> lockup was detected.
>
> Signed-off-by: Eric B Munson<emunson@mgebm.net>

Adding Jeremy since the pvclock ABI is shared across Xen and KVM.

Regards,

Anthony Liguori

> ---
>   arch/x86/include/asm/pvclock-abi.h |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/include/asm/pvclock-abi.h b/arch/x86/include/asm/pvclock-abi.h
> index 35f2d19..6167fd7 100644
> --- a/arch/x86/include/asm/pvclock-abi.h
> +++ b/arch/x86/include/asm/pvclock-abi.h
> @@ -40,5 +40,6 @@ struct pvclock_wall_clock {
>   } __attribute__((__packed__));
>
>   #define PVCLOCK_TSC_STABLE_BIT	(1<<  0)
> +#define PVCLOCK_GUEST_STOPPED	(1<<  1)
>   #endif /* __ASSEMBLY__ */
>   #endif /* _ASM_X86_PVCLOCK_ABI_H */
