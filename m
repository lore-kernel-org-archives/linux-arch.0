Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:18637 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261764AbUDDKYH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 Apr 2004 06:24:07 -0400
Date: Sun, 4 Apr 2004 12:24:04 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Message-Id: <20040404122404.54329a2e.ak@suse.de>
In-Reply-To: <200404040222.41413.arnd@arndb.de>
References: <200404040204.03594.arnd@arndb.de>
	<200404040222.41413.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 4 Apr 2004 02:22:40 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> sys32_select has seven mostly but not exactly identical versions,
> so consolidate them as compat_sys_select. Based on the ppc64
> implementation, which most closely resembles sys_select.
> 
> Passes relevant LTP test cases on x86_64.

I'm a bit dubious about LTP - often their test cases are very poor
and just check EFAULT behaviour. For testing it's better to just boot 
a 32bit distribution and make sure that at least some X desktop
works. That said your patches look fine to me.

-Andi
