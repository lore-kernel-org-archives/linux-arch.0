From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Mon, 02 Feb 2015 11:23:57 +1100
Message-ID: <1422836637.17302.9.camel@au1.ibm.com>
References: <1422361485.6648.71.camel@opensuse.org>
	 <54C78756.9090605@suse.cz>
	 <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	 <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
	 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	 <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
	 <CAMo8BfLsKCV_2NfgMH4k9jGOHs_-3=NKjCD3o3KK1uH23-6RRg@mail.gmail.com>
	 <CA+55aFzQ5QEZ1AYauWviq1gp5j=mqByAtt4fpteeK7amuxcyjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:34415 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbbBBAZC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Feb 2015 19:25:02 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <benh@au1.ibm.com>;
	Mon, 2 Feb 2015 10:24:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 208A22CE804E
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2015 11:24:55 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t120Okoa40108156
	for <linux-arch@vger.kernel.org>; Mon, 2 Feb 2015 11:24:55 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t120OL54012325
	for <linux-arch@vger.kernel.org>; Mon, 2 Feb 2015 11:24:21 +1100
In-Reply-To: <CA+55aFzQ5QEZ1AYauWviq1gp5j=mqByAtt4fpteeK7amuxcyjw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Takashi Iwai <tiwai@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>

On Thu, 2015-01-29 at 10:16 -0800, Linus Torvalds wrote:
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index eb79907f34fa..6154b0a2b063 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -437,6 +437,8 @@ good_area:
>          */
>         fault = handle_mm_fault(mm, vma, address, flags);
>         if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
> +               if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 rc = mm_fault_error(regs, address, fault);
>                 if (rc >= MM_FAULT_RETURN)
>                         goto bail;

I prefer having the test inside mm_fault_error(), even if that makes the
patch a bit bigger, it keeps the logic in a single place. Untested
patch:

--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -184,6 +184,12 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 		return MM_FAULT_RETURN;
 	}
 
+	/* Other faults */
+
+	if (fault & VM_FAULT_SIGSEGV) {
+		up_read(&current->mm->mmap_sem);
+		return MM_FAULT_ERR(SIGSEGV);
+	}
 	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
 		return do_sigbus(regs, addr, fault);
 


Cheers,
Ben.
