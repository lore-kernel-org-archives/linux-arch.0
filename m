From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 22/29] Disintegrate asm/system.h for S390
Date: Thu, 8 Mar 2012 12:18:28 +0100
Message-ID: <20120308121828.2cdbdc8c@de.ibm.com>
References: <20120307194548.15987.36073.stgit@warthog.procyon.org.uk>
	<20120307195001.15987.31240.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:34195 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2CHLSp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2012 06:18:45 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Thu, 8 Mar 2012 11:18:44 -0000
In-Reply-To: <20120307195001.15987.31240.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, sfr@canb.auug.org.au, mingo@redhat.com, arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 07 Mar 2012 19:50:01 +0000
David Howells <dhowells@redhat.com> wrote:

> diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
> index 06faf6a..d7008d1 100644
> --- a/arch/s390/include/asm/sigp.h
> +++ b/arch/s390/include/asm/sigp.h
> @@ -14,6 +14,14 @@
>  /* Get real cpu address from logical cpu number. */
>  extern unsigned short __cpu_logical_map[];
> 
> +static inline unsigned short stap(void)
> +{
> +	unsigned short cpu_address;
> +
> +	asm volatile("stap %0" : "=m" (cpu_address));
> +	return cpu_address;
> +}
> +
>  static inline int cpu_logical_map(int cpu)
>  {
>  #ifdef CONFIG_SMP

This hunk will conflict with "[PATCH] rework smp code" in the linux-next
tree. The sigp.h header is disintegrated as well..
But except for this little hiccup I like the idea to split system.h,
makes a lot of sense.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
