Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:60733 "EHLO
	tomts25-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754373AbXKOM0x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 07:26:53 -0500
Received: from toip5.srvr.bell.ca ([209.226.175.88])
          by tomts25-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20071115122652.XNAY19497.tomts25-srv.bellnexxia.net@toip5.srvr.bell.ca>
          for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2007 07:26:52 -0500
Date: Thu, 15 Nov 2007 07:21:51 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Subject: Re: HAVE or ARCH_HAS or ARCH_SUPPORTS and use of select
Message-ID: <20071115122151.GA10359@Krystal>
References: <20071115090215.GA20612@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20071115090215.GA20612@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
List-ID: <linux-arch.vger.kernel.org>

* Sam Ravnborg (sam@ravnborg.org) wrote:
> I just asked Mathieu to use ARCH_HAS_<config-symbol>
> when an architecture should say that it uses the
> generic KPROBSE functionality.
> 
> ARCH_HAS was selected from a pure "what is most popular today"
> grep of the kernel source.
> 
> It is used roughly like this:
> 
> *Generic Kconfig file:*
> config KPROBES
> 	depends on ARCH_HAS_KPROBES
> 	bool "bla bla"
> 
> # let arch that support KPROBES select the below symbol.
> # Note: no dependencies allowed on ARCH_HAS_ symbols!
> config ARCH_HAS_KPROBES
> 	def_bool n
> 
> *Arch specific Kconfig file:*
> config X86
> 	select ARCH_HAS_KPROBES
> 
> 
> But I felt a bit uneasy with the wording "ARCH_HAS" because
> in reality it is "ARCH_USES" or "ARCH_SUPPORTS" because
> in this case X86 uses the generic KPROBES functionality
> or maybe it just supports it.
> On the config level do we really want to ditingush between "HAS",
> "SUPPORTS", "USE" and whatever the next person come up with?
> 
> automake and friends uses HAVE_ and I dunno about other tools.
> 

FWIW, I've used "NEED_*" in my LTTng patchset to specify when an
architecture needs support from an architecture independent module. (it
could be an alternative to USE_*).

Mathieu

> Could we come up with a naming that fits the current usages we
> could standardize on this.
> When we have it defined I will update kconfig-language.txt
> and try to chase people that fail to use the naming scheme.
> (Or I will ask Randy to do it so it is readable for humans..)
> 
> For x86 for instance there is potential for some cleaning and likewise
> in other archs.
> 
> 	Sam
> 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
