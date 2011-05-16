From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 0/4] [RFC] mcount address adjustment
Date: Mon, 16 May 2011 10:28:46 -0400
Message-ID: <1305556127.5456.1.camel@gandalf.stny.rr.com>
References: <20110510081039.241831019@de.ibm.com>
	 <BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
	 <20110512112454.2fa7e6d6@mschwide>
	 <BANLkTinY+gDxoHk4378kXd8WH-hf9CN6ZA@mail.gmail.com>
	 <20110516125717.GB7715@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:53733 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1EPO2u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2011 10:28:50 -0400
In-Reply-To: <20110516125717.GB7715@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <dave.martin@linaro.org>
Cc: Rabin Vincent <rabin@rab.in>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, 2011-05-16 at 13:57 +0100, Dave Martin wrote:

> Is there any reason why the recordmcount.pl would ever be used now that the
> C implementation exists?
> 
> I notice that arch/arm/Kconfig has:
> 
> config ARM
> ...
>         select HAVE_C_RECORDMCOUNT
> 
> so deprecating ARM support from recordmcount.pl seems unlikely to hurt
> anyone.
> 
> The C implementation seems to have worked fine when I was testing dynamic
> ftrace with Thumb-2 recently.

It's there only as a backup. But you're right. I may as well start
removing the recordmcount.pl support from those that have the
HAVE_C_RECORDMCOUNT set, and then all users are gone (which may now be
the case) either keep it around as a backup for testing against
recordmcount.c, or remove it completely.

-- Steve
