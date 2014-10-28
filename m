From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 21/29] nios2: Time keeping
Date: Tue, 28 Oct 2014 14:39:46 +0100
Message-ID: <2258102.tG8NmIz9Bk@wuerfel>
References: <1414139071-3818-1-git-send-email-lftan@altera.com> <1806277.3CF96bVORX@wuerfel> <1414492984.2295.8.camel@leyfoon-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414492984.2295.8.camel@leyfoon-vm>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 28 October 2014 18:43:04 Ley Foon Tan wrote:
> On Sel, 2014-10-28 at 10:23 +0100, Arnd Bergmann wrote:
> > On Tuesday 28 October 2014 10:46:29 Ley Foon Tan wrote:
> > > On Sun, Oct 26, 2014 at 5:10 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > On Fri, 24 Oct 2014, Ley Foon Tan wrote:
> > > >> +#ifndef _ASM_NIOS2_TIMEX_H
> > > >> +#define _ASM_NIOS2_TIMEX_H
> > > >> +
> > > >> +typedef unsigned long cycles_t;
> > > >> +
> > > >> +extern cycles_t get_cycles(void);
> > > >> +
> > > >> +#define ARCH_HAS_READ_CURRENT_TIMER
> > > >
> > > > Why does NIOS need that? Does it have a hardware implementation
> > > > dependent clock frequency which needs to be calibrated at boot time?
> > > This is suggestion from Arnd to use read_current_timer instead of using
> > > expensive delay loop calibration during boot.
> > 
> > My mistake, sorry. I think the right way is to define
> > calibrate_delay_is_known() rather than read_current_timer(), I was
> > getting confused by the ARM implementation that does both.
> Hi Arnd,
> No problem, I can change that. But, seem that we don't need to have
> calibrate_delay_is_known() as well. We can just set "lpj_fine" variable,
> arm64 uses this.

Right, that works too.

> BTW, do you have further comment for other patches in this series? Only
> few minor updates since v4 patches and would like to get it into the
> v3.18 merge window if possible. What's your opinion? 

The 3.18 merge window is closed, we already have 3.18-rc2 now.

I have taken another look over the series now, I only had
a few additional comments. Please fix those along with the comments
you got from other reviewers and then ask Stephen Rothwell to
include your tree in linux-next (if it isn't already).

When 3.18 is released, you can then send a pull request to Linus.

	Arnd
