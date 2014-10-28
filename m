From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v5 21/29] nios2: Time keeping
Date: Tue, 28 Oct 2014 18:43:04 +0800
Message-ID: <1414492984.2295.8.camel@leyfoon-vm>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
	 <alpine.DEB.2.11.1410252258570.5308@nanos>
	 <CAFiDJ5_zsyQ92W4iYG2Ria12TKpkFa8Au5noos1=gtq6_aPyjg@mail.gmail.com>
	 <1806277.3CF96bVORX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1806277.3CF96bVORX@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Sel, 2014-10-28 at 10:23 +0100, Arnd Bergmann wrote:
> On Tuesday 28 October 2014 10:46:29 Ley Foon Tan wrote:
> > On Sun, Oct 26, 2014 at 5:10 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Fri, 24 Oct 2014, Ley Foon Tan wrote:
> > >> +#ifndef _ASM_NIOS2_TIMEX_H
> > >> +#define _ASM_NIOS2_TIMEX_H
> > >> +
> > >> +typedef unsigned long cycles_t;
> > >> +
> > >> +extern cycles_t get_cycles(void);
> > >> +
> > >> +#define ARCH_HAS_READ_CURRENT_TIMER
> > >
> > > Why does NIOS need that? Does it have a hardware implementation
> > > dependent clock frequency which needs to be calibrated at boot time?
> > This is suggestion from Arnd to use read_current_timer instead of using
> > expensive delay loop calibration during boot.
> 
> My mistake, sorry. I think the right way is to define
> calibrate_delay_is_known() rather than read_current_timer(), I was
> getting confused by the ARM implementation that does both.
Hi Arnd,
No problem, I can change that. But, seem that we don't need to have
calibrate_delay_is_known() as well. We can just set "lpj_fine" variable,
arm64 uses this.

BTW, do you have further comment for other patches in this series? Only
few minor updates since v4 patches and would like to get it into the
v3.18 merge window if possible. What's your opinion? 

Thanks.

Regards
Ley Foon



