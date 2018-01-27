Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752577AbeA0KP4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jan 2018 05:15:56 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0RAEH5j129742
        for <linux-arch@vger.kernel.org>; Sat, 27 Jan 2018 05:15:55 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2frq698fvr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 27 Jan 2018 05:15:55 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 27 Jan 2018 10:15:53 -0000
Date: Sat, 27 Jan 2018 11:15:46 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 8/8] kprobes/s390: Fix %p uses in error messages
References: <151685799071.3099.10383062804474021403.stgit@devbox>
 <151685823207.3099.1804053958699756937.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151685823207.3099.1804053958699756937.stgit@devbox>
Message-ID: <20180127101546.GA3915@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180127101546.azx123oYzT7av4ifg_iBn0UUSAQuZl6_LN4vVfk6TAg@z>

On Thu, Jan 25, 2018 at 02:30:32PM +0900, Masami Hiramatsu wrote:
> Remove %p because the kprobe will be dumped in
> dump_kprobe().
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/s390/kernel/kprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
> index af3722c28fd9..df30e5b9a572 100644
> --- a/arch/s390/kernel/kprobes.c
> +++ b/arch/s390/kernel/kprobes.c
> @@ -282,7 +282,7 @@ static void kprobe_reenter_check(struct kprobe_ctlblk *kcb, struct kprobe *p)
>  		 * is a BUG. The code path resides in the .kprobes.text
>  		 * section and is executed with interrupts disabled.
>  		 */
> -		printk(KERN_EMERG "Invalid kprobe detected at %p.\n", p->addr);
> +		pr_err("Invalid kprobe detected.\n");

Given that this change makes sense anyway, I just applied it to the s390
tree. :)

Thanks!
