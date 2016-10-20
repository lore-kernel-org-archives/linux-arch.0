From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 3/3] thread_info: include <current.h> for
 THREAD_INFO_IN_TASK
Date: Thu, 20 Oct 2016 12:29:26 +0200
Message-ID: <20161020102925.GA3529@osiris>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
 <1476901693-8492-4-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754041AbcJTK3i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Oct 2016 06:29:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9KASkn2126892
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2016 06:29:37 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 266c36tn7n-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2016 06:29:37 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 20 Oct 2016 11:29:32 +0100
Content-Disposition: inline
In-Reply-To: <1476901693-8492-4-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, hpa@zytor.com, keescook@chromium.org, luto@kernel.org, mingo@redhat.com, tglx@linutronix.de

On Wed, Oct 19, 2016 at 07:28:13PM +0100, Mark Rutland wrote:
> When CONFIG_THREAD_INFO_IN_TASK is selected, the current_thread_info()
> macro relies on current having been defined prior to its use. However,
> not all users of current_thread_info() include <asm/current.h>, and thus
> current is not guaranteed to be defined.
> 
> When CONFIG_THREAD_INFO_IN_TASK is not selected, it's possible that
> get_current() / current are based upon current_thread_info(), and
> <asm/current.h> includes <asm/thread_info.h>. Thus always including
> <asm/current.h> would result in circular dependences on some platforms.
> 
> To ensure both cases work, this patch includes <asm/current.h>, but only
> when CONFIG_THREAD_INFO_IN_TASK is selected.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Kees Cook <keescook@chromium.org> 
> ---
>  include/linux/thread_info.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index c75c6ab..ef1f4b0 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -12,6 +12,7 @@
>  #include <linux/restart_block.h>
>  
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> +#include <asm/current.h>
>  #define current_thread_info() ((struct thread_info *)current)
>  #endif

FWIW:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
