Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8887
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932150AbWDFEle (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Apr 2006 00:41:34 -0400
Date: Wed, 05 Apr 2006 21:41:20 -0700 (PDT)
Message-Id: <20060405.214120.71087991.davem@davemloft.net>
Subject: Re: 32-on-64 (x86-64) siginfo corruption
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <787b0d920604052020rdaa5146q58720e7fd82ce0bb@mail.gmail.com>
References: <787b0d920604052020rdaa5146q58720e7fd82ce0bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: acahalan@gmail.com
Cc: ak@muc.de, ak@suse.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: "Albert Cahalan" <acahalan@gmail.com>
Date: Wed, 5 Apr 2006 23:20:07 -0400

> The situation:  32-bit debugger, 32-bit child, 64-bit kernel
> 
> The debugger sends an RT signal to the child. (to stop it, with
> a queue and siginfo so that non-debugger signals don't get lost)
> To do this, the debugger uses tgkill().
> 
> Later, the debugger checks the child's siginfo_t before discarding
> it. This is to be sure that the child didn't get the RT signal from
> some other source. The debugger fills a siginfo_t with 0xff, then
> fetches siginfo data via ptrace. The data is corrupt:
> 
> FIELD     32-ON-64   NORMAL
> si_pid      -1       getpid()
> si_uid    getpid()   getuid()
> 
> The "getpid" and "getuid" above are done in the debugger, not in
> the child. The si_code values are SI_TKILL.
> 
> Probably the other ports with 32-on-64 support ought to verify
> that this stuff works right.

Ugh, just like PTRACE_GETEVENTMSG we'll need translations for
GETSIGINFO and SETSIGINFO.

I've CC'd linux-arch which is where the port maintainers hang
out and look for postings about issues like this.  I mentioned
the PTRACE_GETEVENTMSG issue there just the other day.
