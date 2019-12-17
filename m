From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
Date: Tue, 17 Dec 2019 17:48:10 +0000
Message-ID: <20191217174808.GM5624@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-13-catalin.marinas@arm.com>
 <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
 <87zhfxqu1q.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87zhfxqu1q.fsf@x220.int.ebiederm.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Arnd Bergmann <arnd@arndb.de>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, Linux-MM <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Eric,

On Thu, Dec 12, 2019 at 12:26:41PM -0600, Eric W. Biederman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>
> >> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >>
> >> Add MTE-specific SIGSEGV codes to siginfo.h.
> >>
> >> Note that the for MTE we are reusing the same SPARC ADI codes because
> >> the two functionalities are similar and they cannot coexist on the same
> >> system.
> 
> Please Please Please don't do that.
> 
> It is actively harmful to have architecture specific si_code values.
> As it makes maintenance much more difficult.
> 
> Especially as the si_codes are part of union descrimanator.
> 
> If your functionality is identical reuse the numbers otherwise please
> just select the next numbers not yet used.

It makes sense.

> We have at least 256 si_codes per signal 2**32 if we really need them so
> there is no need to be reuse numbers.
> 
> The practical problem is that architecture specific si_codes start
> turning kernel/signal.c into #ifdef soup, and we loose a lot of
> basic compile coverage because of that.  In turn not compiling the code
> leads to bit-rot in all kinds of weird places.

Fortunately for MTE we don't need to change kernel/signal.c. It's
sufficient to call force_sig_fault() from the arch code with the
corresponding signo, code and fault address.

> p.s. As for coexistence there is always the possibility that one chip
> in a cpu family does supports one thing and another chip in a cpu
> family supports another.  So userspace may have to cope with the
> situation even if an individual chip doesn't.
> 
> I remember a similar case where sparc had several distinct page table
> formats and we had a single kernel that had to cope with them all.

We have such fun on ARM as well with the big.LITTLE systems where not
all CPUs support the same features. For example, MTE is only enabled
once all the secondary CPUs have booted and confirmed to have the
feature.

Thanks.

-- 
Catalin
