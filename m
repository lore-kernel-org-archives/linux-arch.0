Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:44800 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbbA2Etw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jan 2015 23:49:52 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Wed, 28 Jan 2015 07:38:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 67DC51B08061
	for <linux-arch@vger.kernel.org>; Wed, 28 Jan 2015 07:38:42 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0S7ccJC11534756
	for <linux-arch@vger.kernel.org>; Wed, 28 Jan 2015 07:38:38 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0S2YV8h019068
	for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2015 21:34:31 -0500
Date: Wed, 28 Jan 2015 08:38:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Message-ID: <20150128073837.GC4633@osiris>
References: <1422361485.6648.71.camel@opensuse.org>
 <54C78756.9090605@suse.cz>
 <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
 <1422364084.6648.82.camel@opensuse.org>
 <s5h7fw8hvdp.wl-tiwai@suse.de>
 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
 <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>
Message-ID: <20150128073837.h7D_cpmStr2uEV3Nauqtlm0Fv6jZ03qZRDsauGVx4Hg@z>

On Tue, Jan 27, 2015 at 12:57:20PM -0800, Linus Torvalds wrote:
> [ Adding 'linux-arch' to the recipients, since this touches pretty
> much all architectures ]
[...]
> Can people take a look?
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 811937bb90be..9065d5aa3932 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -374,6 +374,12 @@ static noinline void do_fault_error(struct pt_regs *regs, int fault)
>  				do_no_context(regs);
>  			else
>  				pagefault_out_of_memory();
> +		} else if (fault & VM_FAULT_SIGSEGV) {
> +			/* Kernel mode? Handle exceptions or die */
> +			if (!user_mode(regs))
> +				do_no_context(regs);
> +			else
> +				do_sigsegv(regs, SEGV_MAPERR);

s390 still compiles and boots with this patch applied.

