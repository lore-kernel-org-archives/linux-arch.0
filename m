From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] asm-generic/pgtable-nop?d.h: define folded with a value
 for use in C
Date: Thu, 4 Oct 2018 10:45:00 +0100
Message-ID: <20181004094500.GA108096@arrakis.emea.arm.com>
References: <20181003175052.31917-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181003175052.31917-1-james.morse@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: James Morse <james.morse@arm.com>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 03, 2018 at 06:50:52PM +0100, James Morse wrote:
> It turns out "if (__is_defined(__PAGETABLE_PMD_FOLDED))" isn't equivalent
> to "#ifdef __PAGETABLE_PMD_FOLDED". (who knew!)
> 
> kconfig.h's __is_defined() expects a define of the form
> "#define CONFIG_BOOGER 1". But these nop?d headers just have
> "#define __PAGETABLE_PMD_FOLDED".

I wonder why we're using __is_defined() at all on arm64. It looks like
some internal kconfig.h helper for IS_ENABLED() etc. Even if it looks
nicer, I'd rather go for an #ifdef in the arm64 set_pmd() code.

-- 
Catalin
