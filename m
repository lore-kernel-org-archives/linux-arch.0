Return-Path: <carlos@baldric.uwo.ca>
Received: from baldric.uwo.ca ([129.100.10.225]:42756 "EHLO baldric")
	by vger.kernel.org with ESMTP id S261905AbUB1TQs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 14:16:48 -0500
Date: Sat, 28 Feb 2004 14:15:37 -0500
From: "Carlos O'Donell" <carlos@baldric.uwo.ca>
Subject: Re: compat-signal-noarch-2004-01-29.patch
Message-ID: <20040228191536.GA19963@baldric.uwo.ca>
References: <20040226043605.GD17229@baldric.uwo.ca> <20040229021045.78ac9466.ak@suse.de> <20040226155930.GB24779@baldric.uwo.ca> <20040226173115.7bd1aa86.ak@suse.de> <20040226163812.GP25779@parcelfarce.linux.theplanet.co.uk> <20040226174753.4319802c.ak@suse.de> <20040226194747.GA28037@baldric.uwo.ca> <20040226205058.5a0d1e34.ak@suse.de> <20040227234037.GB10923@baldric.uwo.ca> <20040302213932.55852152.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302213932.55852152.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: willy@debian.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> If you really don't want to do that please provide a way that I can
> define away the compat task macro for x86-64 at least (although that
> would be a bad idea, just not having it would be better)

Already done, it's part of the change.

In include/linux/compat.h we include include/asm/compat.h first.
Thus, define HAVE_ARCH_IS_COMPAT_TASK and your own version of
is_compat_task.
 
Example untested patch for x86_64 provided at the end.

> No, it doesn't exist yet. I just don't want to close the door for such
> future enhancements. There is a patch for IA64 that does this though.
> I really don't want this generic macro thing for x86-64. 

That's your decision to make Andi, and I've infact taken that into
account by allowing arches to override the default behaviour of
is_compat_task() *and* all the associated compat functions called by
that check (e.g. compat_copy_siginfo_to_user and HAVE_ARCH_*).

I agree wholeheartedly. I don't want to remove choice, but I do want to
make maintenance easier, and reduce duplication of effort.

> They are pretty standard, except for the odd long long is different
> from long long in 32bit requirement (which many people who try to
> design compat compatible interfaces get wrong unfortunately because
> it's a non issue on the RISCs) 

AFAIK 'long long' has to be a _minimum_ of 64-bits, but may infact be
larger. Implementation details always have to be worked out by hand :o)

The patch below will effectively remove is_compat_task() for x86_64.
Apply it if you wish. You can do a number of nasty things with the
definition of is_compat_task() in order to catch improper uses.

c.

--- a/include/asm-x86_64/compat.h	28 Feb 2004 01:51:30 -0000	1.2
+++ b/include/asm-x86_64/compat.h	28 Feb 2004 19:02:06 -0000
@@ -9,6 +9,9 @@
 
 #define COMPAT_USER_HZ	100
 
+#define HAVE_ARCH_IS_COMPAT_TASK
+#define is_compat_task(x) 0
+
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
