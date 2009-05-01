From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH 35/35] remove old ptemap.h includes
Date: Fri, 1 May 2009 16:59:17 +0200
Message-ID: <20090501145917.GB7618@elte.hu>
References: <20090501144201.D31EF417@kernel> <20090501144255.35FCBB72@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:47709 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765294AbZEAO7U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 10:59:20 -0400
Content-Disposition: inline
In-Reply-To: <20090501144255.35FCBB72@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


* Dave Hansen <dave@linux.vnet.ibm.com> wrote:

> +++ linux-2.6.git-dave/arch/alpha/include/asm/pgtable.h	2009-04-30 15:11:13.000000000 -0700
> @@ -317,7 +317,7 @@ extern inline pte_t * pte_offset_kernel(
>  	return ret;
>  }
>  
> -#inclue <asm/ptemap.h>
> +#include <asm/ptemap.h>

that typo fix should be backmerged to earlier in the series i guess.

	Ingo
