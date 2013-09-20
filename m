From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch 2/6] h8300: Use schedule_preempt_irq
Date: Fri, 20 Sep 2013 10:41:44 -0700
Message-ID: <20130920174144.GA30356@roeck-us.net>
References: <20130917082838.218329307@infradead.org>
 <20130917182350.449685712@linutronix.de>
 <20130917183628.646285522@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130917183628.646285522@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Arjanvan@roeck-us.net
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 17, 2013 at 06:53:06PM -0000, Thomas Gleixner wrote:
> Use the proper function instead of fiddling with PREEMPT_ACTIVE and
> interrupt enable/disable in the low level code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> 
This will result in a conflict in -next as h8300 support has been removed
there, and I'll send a pull request to Linus in the next commit window.

Guenter
