Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934059AbeEIIcc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 04:32:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w498TN2m135021
        for <linux-arch@vger.kernel.org>; Wed, 9 May 2018 04:32:32 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2huttyq5b0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 09 May 2018 04:32:31 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 9 May 2018 09:32:27 +0100
Date: Wed, 9 May 2018 10:32:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove no-op macro VMLINUX_SYMBOL()
References: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20180509083222.GC3698@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20180509083222.w4ttN3Pp1WC1X9Fl8iirJIGfS5HqV_C69G3D4SU52Ek@z>

On Wed, May 09, 2018 at 04:51:39PM +0900, Masahiro Yamada wrote:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for s390-specific code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 08d12cf..f0414f5 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -82,10 +82,10 @@ SECTIONS
>  
>  	. = ALIGN(PAGE_SIZE);
>  	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
> -		VMLINUX_SYMBOL(_sinittext) = . ;
> +		_sinittext = .;
>  		INIT_TEXT
>  		. = ALIGN(PAGE_SIZE);
> -		VMLINUX_SYMBOL(_einittext) = . ;
> +		_einittext = .;

Applied, thanks.
