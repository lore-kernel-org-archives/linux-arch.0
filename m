From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: "N" symbols and System.map
Date: Mon, 4 May 2009 14:39:50 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA39EFE2CCB@orsmsx505.amr.corp.intel.com>
References: <49FB7692.2000508@linux.intel.com> <m2preso1wl.fsf@igel.home>
	<20090501232149.GA28888@uranus.ravnborg.org>
	<49FB8D27.3000305@linux.intel.com>
	<20090504193336.GA10453@uranus.ravnborg.org> <m2skjkzhu6.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23162 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618AbZEDVjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2009 17:39:51 -0400
In-Reply-To: <m2skjkzhu6.fsf@igel.home>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

> My best guess would be that it has to do with the fact that the _end
> symbol is attached to the .end section which is located before the debug
> sections, but the .end section is empty, so the symbol has the same
> address as the following debug section.

Perhaps a good guess.  Putting something (". = . + PAGE_SIZE;") into
the .end section makes _end change type from "N" tp "B".

-Tony
