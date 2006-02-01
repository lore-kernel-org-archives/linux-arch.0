Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:13717 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030560AbWBAHow (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2006 02:44:52 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: Fw: [PATCH] abstract type/size specification for assembly
Date: Wed, 1 Feb 2006 08:36:09 +0100
References: <20060131143149.35db2e02.akpm@osdl.org>
In-Reply-To: <20060131143149.35db2e02.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010836.09932.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 31 January 2006 23:31, Andrew Morton wrote:
> 
> OK?

Yes.

> 
> 
> From: Jan Beulich <jbeulich@novell.com>
> 
> Provide abstraction for generating type and size information of assembly
> routines and data.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  include/linux/linkage.h |    5 +++++
>  1 files changed, 5 insertions(+)
> 
> diff -puN include/linux/linkage.h~abstract-type-size-specification-for-assembly include/linux/linkage.h
> --- 25/include/linux/linkage.h~abstract-type-size-specification-for-assembly	Tue Jan 31 14:30:58 2006
> +++ 25-akpm/include/linux/linkage.h	Tue Jan 31 14:30:58 2006
> @@ -39,6 +39,11 @@
>    ALIGN; \
>    name:
>  
> +#define ENDPROC(name) \
> +  .type name, @function; \
> +  END(name)
> +#define END(name) \
> +  .size name, .-name
>  
>  #endif
>  
> _
> 
> 
