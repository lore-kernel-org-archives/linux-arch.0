Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:8635 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262293AbUDDLIF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 Apr 2004 07:08:05 -0400
Date: Sun, 4 Apr 2004 04:07:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Message-ID: <20040404110756.GB791@holomorphy.com>
References: <200404040204.03594.arnd@arndb.de> <200404040222.41413.arnd@arndb.de> <20040404122404.54329a2e.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040404122404.54329a2e.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 4 Apr 2004 02:22:40 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>> sys32_select has seven mostly but not exactly identical versions,
>> so consolidate them as compat_sys_select. Based on the ppc64
>> implementation, which most closely resembles sys_select.
>> Passes relevant LTP test cases on x86_64.

On Sun, Apr 04, 2004 at 12:24:04PM +0200, Andi Kleen wrote:
> I'm a bit dubious about LTP - often their test cases are very poor
> and just check EFAULT behaviour. For testing it's better to just boot 
> a 32bit distribution and make sure that at least some X desktop
> works. That said your patches look fine to me.
> -Andi

I can second that one; I've seen stuff that "passes LTP" but blatantly
flunks rather simplistic off-the-cuff a priori sanity checks. One
example that stands out is a recent patch ppl were rather foolishly
trying to get my endorsement on that pandered to (ir)Rational crap code.
I've also found LTP to be insufficient/useless in a number of userspace
ABI compatibility tests as well, where running a different distro
sufficed and full-blown LTP did not.


-- wli
