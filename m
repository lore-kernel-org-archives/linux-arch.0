From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] x86/ce4100: add reg property to bridges
Date: Mon, 11 Apr 2011 19:38:41 +1000
Message-ID: <1302514721.28876.12.camel@pasglop>
References: <1302146796-26825-1-git-send-email-benh@kernel.crashing.org>
	 <1302146796-26825-2-git-send-email-benh@kernel.crashing.org>
	 <20110407121315.GA9204@linutronix.de> <1302213159.2458.43.camel@pasglop>
	 <20110411072340.GA4018@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110411072340.GA4018@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, monstr@monstr.eu, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

On Mon, 2011-04-11 at 09:23 +0200, Sebastian Andrzej Siewior wrote:
> * Benjamin Herrenschmidt | 2011-04-08 07:52:39 [+1000]:
> 
> >Thanks. Are you sending that independently or do you want me to put it
> >in my series before the patch that would "break" it ?
> 
> I would prefer to get it into 39 so I don't have a device tree which
> does not work on a later kernel version.

I've put merged the patch in my series. That's easier for testing.

Cheers,
Ben.
