From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 01/24] kernel: Standardize vdso_datapage
Date: Tue, 15 Jan 2019 16:29:38 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1901151627560.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <20190115135539.24762-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
 <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
> On 15/01/2019 14:57, Thomas Gleixner wrote:
> >> +	u64 mask;		/* Clocksource mask (mono = raw) */
> > 
> > mono = raw? This is broken. The VDSO cannot define time different from the
> > regular syscall interfaces.
> > 
> 
> On v2 of this series I had the masks for mono and raw separate, but based on
> your comment (the core timekeeper has them duplicated purely for access pattern
> optimization and simplicity). I unified them. Could you please provide more
> details on what should be done in this case?

The mask is the same, but the mult is different. I'm not seing how this is
implemented. Both MONO and MONO_RAW invoke do_hres() and use the common
mult/shift pair.

Thanks,

	tglx
