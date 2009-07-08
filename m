From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH percpu 1/2] microblaze: include EXIT_TEXT to _stext
Date: Wed, 08 Jul 2009 12:37:06 +0200
Message-ID: <4A5476D2.7040709@monstr.eu>
References: <4A546646.70305@kernel.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:56612 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZGHKhK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2009 06:37:10 -0400
In-Reply-To: <4A546646.70305@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, microblaze-uclinux@itee.uq.edu.au, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Tony Luck <tony.luck@intel.com>, Mike Frysinger <vapier@gentoo.org>

Tejun Heo wrote:
> From: Michal Simek <monstr@monstr.eu>
> 
> Microblaze wants to throw out EXIT_TEXT during runtime too.  This
> hasn't caused trouble till now because the linker script didn't
> discard EXIT_TEXT and it ended up in its default output section.  As
> discard definition is about to be unified, include EXIT_TEXT into
> _stext explicitly and while at it replace explicit exitcall definition
> to EXIT_CALL.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Michal, I added the commit messaeg and SOB.  If you don't like it
> please let me know.

It is ok. I rechecked it and works.

Thanks,
Michal


> 
> If there's no further objection, I'll commit this and the next patch
> to percpu#for-next.
> 
> Thanks.
> 
>  arch/microblaze/kernel/vmlinux.lds.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: work/arch/microblaze/kernel/vmlinux.lds.S
> ===================================================================
> --- work.orig/arch/microblaze/kernel/vmlinux.lds.S
> +++ work/arch/microblaze/kernel/vmlinux.lds.S
> @@ -23,8 +23,8 @@ SECTIONS {
>  		_stext = . ;
>  		*(.text .text.*)
>  		*(.fixup)
> -
> -		*(.exitcall.exit)
> +               EXIT_TEXT
> +               EXIT_CALL
>  		SCHED_TEXT
>  		LOCK_TEXT
>  		KPROBES_TEXT


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
