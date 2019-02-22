From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v5 08/23] arm64: compat: Add KUSER_HELPERS config option
Date: Fri, 22 Feb 2019 14:09:16 +0000
Message-ID: <20190222140916.cgnq22trogt4dnzc@shell.armlinux.org.uk>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-9-vincenzo.frascino@arm.com>
 <20190222140427.GI42419@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190222140427.GI42419@lakrids.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 02:04:27PM +0000, Mark Rutland wrote:
> I believe that Will wanted to default the kuser helpers off, as applications
> using them need the instruction emulation which is also disabled by default.
> 
> I'm also not sure which binaries we expect to work on arm64, so I'm not sure if
> the ARMv4 reference is correct.

Do you expect ARMv4 - even ARMv4 OABI binaries to fail on ARM64?

(I've run my OABI ARMv4 distro under KVM on Macchiatobin when I've
needed to rebuild a RPM without problems - using its own gcc.  No
observable issues.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
