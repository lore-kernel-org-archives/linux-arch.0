From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 21/29] nios2: Time keeping
Date: Thu, 09 Oct 2014 13:57:36 +0200
Message-ID: <8312001.XfVQ0Jf4Rn@wuerfel>
References: <1412760595-3935-1-git-send-email-lftan@altera.com> <2785501.FjgXQVl8Ik@wuerfel> <alpine.DEB.2.11.1410081814380.4292@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1410081814380.4292@nanos>
Sender: linux-doc-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Wednesday 08 October 2014 18:19:52 Thomas Gleixner wrote:
> Ok, got it. It does not change the fact that the above function is
> butt ugly and completely non intuitive.

Agreed, it could at least use a comment to explain the logic behind it.

> I also do not agree, that the DT should not tell which of the timers
> should be used as a clockevent device and which one as a
> clocksource. If you have a better suited clockevent device in your
> FPGA, you cannot use a single instance of the timer thingy as it will
> be registered as a clockevent and not as a clocksource. So explicit
> match values for particular hardware instances would be more flexible,
> but I don't have strong feelings about it either.

Right, things can get arbitrarily complicated when this is combined
with other (optional) timer hardware, as we've seen on ARM before.
I think we have discussed the issue for some ARM timers in length
before and not found a good solution.

The clps711x driver has tried to work around this problem by using
aliases, and it has been discussed for other drivers before.

The main problem with encoding the use of the timer blocks in DT
is that it gets really ugly if we ever want to use a third timer
hardware block in the kernel, e.g. to separate the timer wheel
from the hrtimer, if we decide to expose a particular HW
timer to in-kernel or userland interfaces, or if someone wants
to run an OS on the same hardware that uses the timer hardware
in a completely different way.

	Arnd
