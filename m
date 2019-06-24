From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Sun, 23 Jun 2019 20:24:30 -0400
Message-ID: <20190624002430.GN2226@sasha-vm>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <20190624075834.2491a61a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190624075834.2491a61a@canb.auug.org.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-hyperv@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mikelley@microsoft.com>, Peter Collingbourne <pcc@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Huw Davies <huw@codeweavers.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-mips@vger.kernel.org" <linux-mips@v>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 24, 2019 at 07:58:34AM +1000, Stephen Rothwell wrote:
>Hi Sasha,
>
>On Sun, 23 Jun 2019 15:09:29 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>
>> Appologies about this. I ended up with way more travel than I would have
>> liked (writing this from an airport). I've reset our hyperv-next branch
>> to remove these 3 commits until we figure this out.
>
>But not pushed out, yet?

Pushed now. For some reason the airport wifi was blocking ssh :/

--
Thanks,
Sasha
