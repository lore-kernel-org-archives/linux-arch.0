From: Michal Simek <monstr@monstr.eu>
Subject: Re: [microblaze-uclinux] [RFC PATCH] linker script: unify usage of
 discard definition
Date: Mon, 06 Jul 2009 08:17:44 +0200
Message-ID: <4A519708.80608@monstr.eu>
References: <4A4E9638.20304@kernel.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57602 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458AbZGFGRq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2009 02:17:46 -0400
In-Reply-To: <4A4E9638.20304@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: microblaze-uclinux@itee.uq.edu.au
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Tony Luck <tony.luck@intel.com>, John Williams <john.williams@petalogix.com>



Tejun Heo wrote:
> Discarded sections in different archs share some commonality but have
> considerable differences.  This led to linker script for each arch
> implementing its own /DISCARD/ definition, which makes maintaining
> tedious and adding new entries error-prone.
> 
> This patch makes all linker scripts to move discard definitions to the
> end of the linker script and use the common DISCARDS macro.  As ld
> uses the first matching section definition, archs can include default
> discarded sections by including them earlier in the linker script.
> 
> On x86-64 which explicitly includes EXIT_TEXT, this produces identical
> output as before and all but one archs included directives (include or
> discard) for all default discarded sections, so this patch shouldn't
> cause any behavior difference.
> 
> The only problem case is microblaze, which didn't explicitly included
> EXIT_TEXT and DATA but didn't discard them either leaving ld to create
> identically names output sections for them.  This patch will make the
> end result different by throwing away exit text and data.  It looks
> like the ommission was accidental and throwing away is the right thing
> to do, but I won't push it till someone who knows microblaze confirms
> it.

Please include EXIT_TEXT to .text section. EXIT_DATA can be discard. Patch is below.

Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal


diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index aa5b0e9..39c0d0b 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -23,8 +23,8 @@ SECTIONS {
                _stext = . ;
                *(.text .text.*)
                *(.fixup)
-
-               *(.exitcall.exit)
+               EXIT_TEXT
+               EXIT_CALL
                SCHED_TEXT
                LOCK_TEXT
                KPROBES_TEXT


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
