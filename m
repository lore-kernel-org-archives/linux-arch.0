From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 08/31] ARC: Fundamental ARCH data-types/defines
Date: Mon, 12 Nov 2012 14:12:47 +0000
Message-ID: <201211121412.47702.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <CACM3HyHAKgJ2aTGjidZr5T9WFL3m+FTbUz_1QtO2gAgSFQm8fA@mail.gmail.com> <50A10091.6020606@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62530 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab2KLOMx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 09:12:53 -0500
In-Reply-To: <50A10091.6020606@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Jonas Bonn <jonas.bonn@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>

On Monday 12 November 2012, Vineet Gupta wrote:
> But just to clarify, gdbserver will still use ARC specific
> ptrace(PEEKUSR) as opposed to regset interface. The switch to new gdb
> version is non trivial and I can't ask our active customers to go to
> some out-of-mainline tree until that gets fixed.

But your customers could use an out-of-tree kernel patch to put the
implementation of PEEKUSR back into their kernels, right?

Over time, they could just drop that patch once they move to a
newer gdb version.

	Arnd
