From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [tip:timers/core] clocksource/drivers: Make Hyper-V clocksource
 ISA agnostic
Date: Sun, 7 Jul 2019 12:06:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1907071205530.3648@nanos.tec.linutronix.de>
References: <1561955054-1838-2-git-send-email-mikelley@microsoft.com>
 <tip-fd1fea6834d0f9f93062ae6685862908a9baed39@git.kernel.org>
 <PU1P153MB0169E8E3898897BF3B3BE0F6BFF40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1907060944200.3648@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907061032400.3648@nanos.tec.linutronix.de>
 <PU1P153MB0169C8A38643B9284C938353BFF40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <PU1P153MB0169C8A38643B9284C938353BFF40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "shuah@kernel.org" <shuah@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.le>
List-Id: linux-arch.vger.kernel.org

On Sat, 6 Jul 2019, Dexuan Cui wrote:
> > On Sat, 6 Jul 2019, Thomas Gleixner wrote:
> Hi Thomas,
> Thanks for the important reminder! I realized actually Michael's patches are
> good, and hibernation can not work because my own hibernation code is buggy:
> in the resume path, on CPU0, I should NOT call hv_stimer_init() -> 
> clockevents_config_and_register(): instead, I should use the event device's 
> suspend/resume callbacks to save/restore the device's state.
> 
> With this kept in mind, I made some small changes to my code and hibernation
> can work fine for me now!
> 
> > > But that needs probably more surgery. I'll add the unbind() call back for
> > > now.
> 
> Can you please drop the unbind() call again? :-)

I restored the original commits without the unbind. All good now :)
