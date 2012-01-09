From: Tony Luck <tony.luck@intel.com>
Subject: why doesn't x86_32 have the accept4() syscall?
Date: Mon, 9 Jan 2012 13:26:41 -0800
Message-ID: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35501 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932Ab2AIV0m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2012 16:26:42 -0500
Received: by vbbfc26 with SMTP id fc26so3018989vbb.19
        for <linux-arch@vger.kernel.org>; Mon, 09 Jan 2012 13:26:41 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

I've been using the warnings from scripts/checksyscalls.sh to let me know
when some new system calls are added, so I can add them to ia64. But
it was recently brought to my attention that I didn't have accept4(). I missed
it because I didn't see a warning, which was because this script just compares
against the 32-bit x86 list.

A casual grep shows that:
alpha, arm, microblaze, mips, parisc, powerpc, sh and sparc
managed to add accept4 without getting the "warning syscall
.... not implemented". But other architectures may need to add
it (including 32-bit x86).

-Tony
