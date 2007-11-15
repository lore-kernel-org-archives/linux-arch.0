Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:53652 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757007AbXKOJBN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 04:01:13 -0500
Date: Thu, 15 Nov 2007 10:02:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: HAVE or ARCH_HAS or ARCH_SUPPORTS and use of select
Message-ID: <20071115090215.GA20612@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux arch <linux-arch@vger.kernel.org>, Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>
List-ID: <linux-arch.vger.kernel.org>

I just asked Mathieu to use ARCH_HAS_<config-symbol>
when an architecture should say that it uses the
generic KPROBSE functionality.

ARCH_HAS was selected from a pure "what is most popular today"
grep of the kernel source.

It is used roughly like this:

*Generic Kconfig file:*
config KPROBES
	depends on ARCH_HAS_KPROBES
	bool "bla bla"

# let arch that support KPROBES select the below symbol.
# Note: no dependencies allowed on ARCH_HAS_ symbols!
config ARCH_HAS_KPROBES
	def_bool n

*Arch specific Kconfig file:*
config X86
	select ARCH_HAS_KPROBES


But I felt a bit uneasy with the wording "ARCH_HAS" because
in reality it is "ARCH_USES" or "ARCH_SUPPORTS" because
in this case X86 uses the generic KPROBES functionality
or maybe it just supports it.
On the config level do we really want to ditingush between "HAS",
"SUPPORTS", "USE" and whatever the next person come up with?

automake and friends uses HAVE_ and I dunno about other tools.

Could we come up with a naming that fits the current usages we
could standardize on this.
When we have it defined I will update kconfig-language.txt
and try to chase people that fail to use the naming scheme.
(Or I will ask Randy to do it so it is readable for humans..)

For x86 for instance there is potential for some cleaning and likewise
in other archs.

	Sam
