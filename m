Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267186AbUIODjn@vger.kernel.org>
Received: from are.twiddle.net ([64.81.246.98]:4226 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S267184AbUIODjn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Sep 2004 23:39:43 -0400
Received: from are.twiddle.net (localhost.localdomain [127.0.0.1])
	by are.twiddle.net (8.12.11/8.12.11) with ESMTP id i8F3dNae000953
	for <linux-arch@vger.kernel.org>; Tue, 14 Sep 2004 20:39:23 -0700
Date: Tue, 14 Sep 2004 20:39:03 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: waitid fallout
Message-ID: <20040915033903.GA904@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: roland@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Is an *entire* struct rusage required in siginfo_t for sigchld?

It's much bigger than the 24 (!) words of padding we had reserved
for expansion in siginfo_t.

Which means that the size of siginfo_t changed, which means that
any existing "sigwaitinfo ({ SIGCHLD }, &info)" will now corrupt
user memory.  Perhaps we think no one does this, but we should
at least be aware of the ABI change.

Alpha is not yet using a VDSO for the signal frame unwind info, so
I noticed that all of my signal cancelation tests are now failing,
because the layout of the signal frame changed.  Perhaps I'll take
this opportunity to update, but it does require a rather coordinated
kernel + libc upgrade in order to keep things working smoothly...


r~
