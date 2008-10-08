From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [patch 0/4] [RFC] true vs. system idle cputime
Date: Wed, 8 Oct 2008 14:22:02 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA353175370@orsmsx505.amr.corp.intel.com>
References: <20081008161958.767142939@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19298 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976AbYJHVXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2008 17:23:20 -0400
In-Reply-To: <20081008161958.767142939@de.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

> There is one change in patch #2 that might require a change on powerpc
> and/or ia64. The generic TICK_ONESHOT/NO_HZ code calculates the number
> of ticks spent with a disabled HZ timer and accounts this as idle time.

Your patches apply, build and boot cleanly on ia64.

At the moment ia64 doesn't do NO_HZ (exisiting cpus only support a C1
state, which we can enter/leave pretty quickly ... so power saving
for NO_HZ is negligible) ... so your code change isn't an issue for
ia64.


-Tony
