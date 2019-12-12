From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
Date: Thu, 12 Dec 2019 09:34:26 +0000
Message-ID: <20191212093425.GA18258@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-13-catalin.marinas@arm.com>
 <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, Linux-MM <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 08:31:28PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > Add MTE-specific SIGSEGV codes to siginfo.h.
> >
> > Note that the for MTE we are reusing the same SPARC ADI codes because
> > the two functionalities are similar and they cannot coexist on the same
> > system.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  include/uapi/asm-generic/siginfo.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index cb3d6c267181..a5184a5438c6 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -227,8 +227,13 @@ typedef struct siginfo {
> >  # define SEGV_PKUERR   4       /* failed protection key checks */
> >  #endif
> >  #define SEGV_ACCADI    5       /* ADI not enabled for mapped object */
> > -#define SEGV_ADIDERR   6       /* Disrupting MCD error */
> > -#define SEGV_ADIPERR   7       /* Precise MCD exception */
> > +#ifdef __aarch64__
> > +# define SEGV_MTEAERR  6       /* Asynchronous MTE error */
> > +# define SEGV_MTESERR  7       /* Synchronous MTE exception */
> > +#else
> > +# define SEGV_ADIDERR  6       /* Disrupting MCD error */
> > +# define SEGV_ADIPERR  7       /* Precise MCD exception */
> > +#endif
> 
> SEGV_ADIPERR/SEGV_ADIDERR were added together with SEGV_ACCADI,
> it seems a bit odd to make only two of them conditional but not the others.

Ah, I missed this. I think we should drop the #ifdef entirely. There is
no harm in having two different macros with the same value.

> I think we are generally working towards having the same constants
> across architectures even for features that only exist on one of them.

I'd rather keep both the ARM and SPARC naming here as the behaviour may
be subtly different between the two architectures. IIUC, the disrupting
SPARC MCD error on means a memory corruption trap sent to the
hypervisor. On ARM MTE, the asynchronous tag check fault is a pretty
much benign setting of a status flag. The kernel, when detecting this
flag, injects a SIGSEGV on the ret_to_user path. If there's no switch
into the kernel, a user program cannot become aware of the asynchronous
MTE tag check fault.

We also don't have the equivalent of ACCADI.

-- 
Catalin
