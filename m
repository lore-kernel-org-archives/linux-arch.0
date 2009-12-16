From: Michael Davidson <md@google.com>
Subject: failed exec() leaves caller with incorrect personality
Date: Tue, 15 Dec 2009 17:09:06 -0800
Message-ID: <6cc912950912151709r1ed52f49mbb3a0cf7e69e3f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:37526 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934374AbZLPBJN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Dec 2009 20:09:13 -0500
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id nBG199iq014892
	for <linux-arch@vger.kernel.org>; Wed, 16 Dec 2009 01:09:09 GMT
Received: from pzk12 (pzk12.prod.google.com [10.243.19.140])
	by kpbe16.cbf.corp.google.com with ESMTP id nBG197T1028901
	for <linux-arch@vger.kernel.org>; Tue, 15 Dec 2009 17:09:07 -0800
Received: by pzk12 with SMTP id 12so311006pzk.13
        for <linux-arch@vger.kernel.org>; Tue, 15 Dec 2009 17:09:06 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Mike Waychison <mikew@google.com>, Andrew Morton <akpm@linux-foundation.org>

This problem was initially seen on 2.6.26 x86_64 and has been verified
to still exist in 2.6.32.1.

When attempting to exec() a dynamic linked ELF binary, load_elf_binary()
calls the architecture specific SET_PERSONALITY() before attempting
to open the ELF interpreter for that binary. If the open fails or if the sanity
checks fail then the exec fails before the point of no return and returns
an error to the caller. However, depending on exactly what SET_PERSONALITY()
has done, it may already have changed some aspects of the current
personality and not restored them.

The specific issue that we saw on x86_64 involved a 32 bit binary attempting
to exec a 64 bit binary for which the ELF interpreter was missing. In this case
SET_PERSONALITY() maps to set_personality_64bit() in x86/kernel/process_64.c
which immediately clears the TIF_IA32 flag meaning that after the exec fails
we are still running in a 32 bit process but TIF_IA32 is no longer set.

It seems that this could be fixed by having the x86 SET_PERSONALITY()
use the TIF_ABI_PENDING flag to signal to flush_thread() that TIF_IA32
needed to be cleared, but to be strictly correct it would still be necessary
to find a way of restoring the state of READ_IMPLES_EXEC correctly in
current->personality if the exec fails before the point of no return.

Also it isn't clear to me exactly what some other architecture might want
to do in SET_PERSONALITY() or how they should go about undoing it
in the event that the exec() fails early enough to be able to return an error.

The comments in binfmt_elf.c say, for example:

 /*
  * The early SET_PERSONALITY here is so that the lookup
  * for the interpreter happens in the namespace of the
  * to-be-execed image.  SET_PERSONALITY can select an
  * alternate root.

although it doesn't appear that anyone currently does that.

For x86 I am inclined to just modify SET_PERSONALITY() so that
the clearing of TIF_IA32 doesn't happen until we get to flush_thread()
but wondered if anyone had any thoughts on this.

md
