From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 03/31] arm64: Exception handling
Date: Thu, 16 Aug 2012 11:05:37 +0100
Message-ID: <20120816100536.GF31784@mudshark.cambridge.arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
 <201208151303.47743.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201208151303.47743.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 15, 2012 at 02:03:47PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> > +#ifdef CONFIG_AARCH32_EMULATION
> > +#define compat_thumb_mode(regs) \
> > +	(((regs)->pstate & COMPAT_PSR_T_BIT))
> > +#else
> > +#define compat_thumb_mode(regs) (0)
> > +#endif
> 
> The symbol we use on other platforms is CONFIG_COMPAT. I don't think you
> need to have a separate CONFIG_AARCH32_EMULATION

Using COMPAT does preclude the possibility of doing something like the x32
ABI later on though. Some other architectures seem to do something similar
(MIPS32_COMPAT, IA32_EMULATION).

Will
