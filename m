From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Mon, 24 Jun 2019 00:12:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190623190929.GL2226@sasha-vm>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Kelley <mikelley@microsoft.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Peter Collingbourne <pcc@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Huw Davies <huw@codeweavers.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-mips@vger.kernel.org" <linux-mi>
List-Id: linux-arch.vger.kernel.org

Sasha,

On Sun, 23 Jun 2019, Sasha Levin wrote:
> On Sat, Jun 22, 2019 at 04:46:28PM +0200, Thomas Gleixner wrote:
> > Folks, please stop chosing Cc lists as you like. We have well established
> > rules for that. And please stop queueing random unreviewed patches in
> > next. Next is not a playground for not ready and unreviewed stuff. No, the
> > hyper-v inbreed Reviewed-by is not sufficient for anything x86 and
> > clocksource related.
> 
> I'm sorry for this, you were supposed to be Cc'ed on these patches and I
> see that you were not.

All good. I've vented steam and am back to normal pressure :)

> > After chasing and looking at those patches, which have horrible subject
> > lines and changelogs btw, I was not able to judge quickly whether that
> > stuff is self contained or not. So no, I fixed up the fallout and rebased
> > Vincenzos VDSO stuff on mainline w/o those hyperv changes simply because if
> > they are not self contained they will break bisection badly.
> > 
> > I'm going to push out the VDSO series later today. That will nicely break

Not yet, but soon :)

> > in combination with the hyper-next branch. Stephen, please drop that and do
> > not try to handle the fallout. That stuff needs to go through the proper
> > channels or at least be acked/reviewed by the relevant maintainers. So the
> > hyper-v folks can rebase themself and post it proper.
> 
> Okay, thank you. We'll rebase and resend.

I have no objections if you collect hyper-v stuff, quite the contrary, but
changes which touch other subsystems need to be coordinated upfront. That's
all I'm asking for.

Btw, that clocksource stuff looks good code wise, just the change logs need
some care and after the VDSO stuff hits next we need to sort out the
logistics. I hope these changes are completely self contained. If not we'll
find a solution.

Thanks,

	tglx
