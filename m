Return-Path: <minyard@acm.org>
Received: from sccrmhc11.comcast.net ([204.127.202.55]:13781 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265841AbUGZVRb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Jul 2004 17:17:31 -0400
Message-ID: <410574E6.2040309@acm.org>
Date: Mon, 26 Jul 2004 16:17:26 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Re: signal-race-fix.patch
References: <20040319120151.380dcbc9.akpm@osdl.org>	<20040319141258.338c91b1.davem@redhat.com>	<405B773B.8010705@acm.org>	<20040319154928.3b2d8820.davem@redhat.com>	<405B8BE5.4070602@acm.org> <20040323022020.3972af1d.akpm@osdl.org>
In-Reply-To: <20040323022020.3972af1d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I haven't seen anything for this, this is not in the current Linus or mm 
releases.  Did I miss something?

Thanks,

-Corey

Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>Here's another patch with the SEGV problems handled and the ka's renamed 
>> to ka_copy.
>>    
>>
>
>Are there any remaining concerns with Corey's final patch?
>
>
> 25-akpm/arch/i386/kernel/signal.c |   60 +++++++++++++++++---------------------
> 25-akpm/include/linux/signal.h    |    2 -
> 25-akpm/kernel/signal.c           |   12 ++++++-
> 3 files changed, 39 insertions(+), 35 deletions(-)
>  
>
