From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Mon, 24 Jun 2019 02:25:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906240221550.32342@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
 <BYAPR21MB135202F46C4B023B51EBBFD0D7E00@BYAPR21MB1352.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BYAPR21MB135202F46C4B023B51EBBFD0D7E00@BYAPR21MB1352.namprd21.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Kelley <mikelley@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Dmitry Safonov <0x7f454c46@gmail.com>, Peter Collingbourne <pcc@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Huw Davies <huw@codeweavers.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vge
List-Id: linux-arch.vger.kernel.org

On Mon, 24 Jun 2019, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Sunday, June 23, 2019 3:13 PM
> > 
> > I have no objections if you collect hyper-v stuff, quite the contrary, but
> > changes which touch other subsystems need to be coordinated upfront. That's
> > all I'm asking for.
> > 
> > Btw, that clocksource stuff looks good code wise, just the change logs need
> > some care and after the VDSO stuff hits next we need to sort out the
> > logistics. I hope these changes are completely self contained. If not we'll
> > find a solution.
> >
> 
> In my view, the only thing that potentially needs a solution is where the
> Hyper-V clock code used by VDSO ends up in the code tree.  I think the
> right long term place is include/clocksource/hyperv_timer.h.   That location
> is architecture neutral, and the same Hyper-V clock code will be shared by
> the Hyper-V on ARM64 support that's in process.
> 
> Vincenzo's patch set creates a new file arch/x86/include/asm/mshyperv-tsc.h,
> which I will want to move when creating the separate Hyper-V clocksource
> driver.   If you're OK with that file existing for a release and then going away,
> that's fine.  Alternatively, put the code in include/clocksource/hyperv_timer.h
> now as part of the VDSO patch set so it's in the right place from the start.  My
> subsequent patch set will add a few additional tweaks to remove x86-isms
> and fully integrate with the separate Hyper-V clocksource driver.

I don't care whether this goes into 5.3 or later. If you can provide me
rebased self contained patches on top of

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso

I'm happy to pull them in on top.

Thanks,

	tglx
