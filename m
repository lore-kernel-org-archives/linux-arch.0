From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Tue, 27 Jan 2015 13:32:57 -0800
Message-ID: <CA+55aFzHyP1xFhLBUkYTvRTsTe-_PcpQ_Qx0f9e6WEj=0yFt2A@mail.gmail.com>
References: <1422361485.6648.71.camel@opensuse.org>
	<54C78756.9090605@suse.cz>
	<alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	<1422364084.6648.82.camel@opensuse.org>
	<s5h7fw8hvdp.wl-tiwai@suse.de>
	<CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	<alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:54747 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbA0Vc6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jan 2015 16:32:58 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so17893802iec.12
        for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2015 13:32:57 -0800 (PST)
In-Reply-To: <alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Takashi Iwai <tiwai@suse.de>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, Jan 27, 2015 at 1:12 PM, Jan Engelhardt <jengelh@inai.de> wrote:
>
> The 2nd patch (from 12:57:20 -0800) plus the one-liner for mm/memory.c
> at the callsite for check_stack_guard_page makes the test still
> not succeed.

Really? What platform? I get

  ==================
  All 5 tests passed
  ==================

with the patch I sent out, combined with this:

   diff --git a/mm/memory.c b/mm/memory.c
   index 54f3a9b00956..2c3536cc6c63 100644
   --- a/mm/memory.c
   +++ b/mm/memory.c
   @@ -2632,7 +2632,7 @@ static int do_anonymous_page(struct mm_struct
*mm, struct vm_area_struct *vma,

           /* Check if we need to add a guard page to the stack */
           if (check_stack_guard_page(vma, address) < 0)
   -               return VM_FAULT_SIGBUS;
   +               return VM_FAULT_SIGSEGV;

           /* Use the zero-page for reads */
           if (!(flags & FAULT_FLAG_WRITE) && !mm_forbids_zeropage(mm)) {

but since architecture matters, and I run on x86-64, some other
platform might still have issues.

(And yes, I checked that it failed without the patch, so I think I'm
testing the same thing you guys are)

                         Linus
