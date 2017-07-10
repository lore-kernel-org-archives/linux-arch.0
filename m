Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56203 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751095AbdGJEe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jul 2017 00:34:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6A39D5x003467
        for <linux-arch@vger.kernel.org>; Sun, 9 Jul 2017 23:10:21 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjucukufj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 09 Jul 2017 23:10:21 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 10 Jul 2017 13:10:18 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 33/38] powerpc: Deliver SEGV signal on pkey violation
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-34-git-send-email-linuxram@us.ibm.com>
Date: Mon, 10 Jul 2017 08:38:53 +0530
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-34-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-ID: <4cbcc16c-7597-7aa1-ddea-b6bef25df11b@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170710030853.Ly-8FYnamT4jXs17Ol4aGyQ1wKgP2D2BkTUNVmKSz2s@z>

On 07/06/2017 02:52 AM, Ram Pai wrote:
> The value of the AMR register at the time of exception
> is made available in gp_regs[PT_AMR] of the siginfo.
> 
> The value of the pkey, whose protection got violated,
> is made available in si_pkey field of the siginfo structure.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/ptrace.h |    3 ++-
>  arch/powerpc/kernel/signal_32.c        |    5 +++++
>  arch/powerpc/kernel/signal_64.c        |    4 ++++
>  arch/powerpc/kernel/traps.c            |   14 ++++++++++++++
>  4 files changed, 25 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 8036b38..7ec2428 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -108,8 +108,9 @@ struct pt_regs {
>  #define PT_DAR	41
>  #define PT_DSISR 42
>  #define PT_RESULT 43
> -#define PT_DSCR 44
>  #define PT_REGS_COUNT 44
> +#define PT_DSCR 44
> +#define PT_AMR	45

Why PT_DSCR was moved down ? This change is redundant here.
