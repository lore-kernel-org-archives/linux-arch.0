From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Date: Fri, 3 Apr 2020 14:37:19 +0100
Message-ID: <20200403133719.GC25745@shell.armlinux.org.uk>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
 <20200403005831.GI23230@ZenIV.linux.org.uk>
 <20200403112609.GB26633@mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200403112609.GB26633@mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, akpm@linux-foundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 03, 2020 at 12:26:10PM +0100, Catalin Marinas wrote:
> On Fri, Apr 03, 2020 at 01:58:31AM +0100, Al Viro wrote:
> > On Thu, Apr 02, 2020 at 11:35:57AM -0700, Kees Cook wrote:
> > > Yup, I think it's a weakness of the ARM implementation and I'd like to
> > > not extend it further. AFAIK we should never nest, but I would not be
> > > surprised at all if we did.
> > > 
> > > If we were looking at a design goal for all architectures, I'd like
> > > to be doing what the public PaX patchset did for their memory access
> > > switching, which is to alarm if calling into "enable" found the access
> > > already enabled, etc. Such a condition would show an unexpected nesting
> > > (like we've seen with similar constructs with set_fs() not getting reset
> > > during an exception handler, etc etc).
> > 
> > FWIW, maybe I'm misreading the ARM uaccess logics, but... it smells like
> > KERNEL_DS is somewhat more dangerous there than on e.g. x86.
> > 
> > Look: with CONFIG_CPU_DOMAINS, set_fs(KERNEL_DS) tells MMU to ignore
> > per-page permission bits in DOMAIN_KERNEL (i.e. for kernel address
> > ranges), allowing them even if they would normally be denied.  We need
> > that for actual uaccess loads/stores, since those use insns that pretend
> > to be done in user mode and we want them to access the kernel pages.
> > But that affects the normal loads/stores as well; unless I'm misreading
> > that code, it will ignore (supervisor) r/o on a page.  And that's not
> > just for the code inside the uaccess blocks; *everything* done under
> > KERNEL_DS is subject to that.
> 
> That's correct. Luckily this only affects ARMv5 and earlier. From ARMv6
> onwards, CONFIG_CPU_USE_DOMAINS is no longer selected and the uaccess
> instructions are just plain ldr/str.
> 
> Russell should know the details on whether there was much choice. Since
> the kernel was living in the linear map with full rwx permissions, the
> KERNEL_DS overriding was probably not a concern and the ldrt/strt for
> uaccess deemed more secure. We also have weird permission setting
> pre-ARMv6 (or rather v6k) where RO user pages are writable from the
> kernel with standard str instructions (breaking CoW). I don't recall
> whether it was a choice made by the kernel or something the architecture
> enforced. The vectors page has to be kernel writable (and user RO) to
> store the TLS value in the absence of a TLS register but maybe we could
> do this via the linear alias together with the appropriate cache
> maintenance.
> 
> From ARMv6, the domain overriding had the side-effect of ignoring the XN
> bit and causing random instruction fetches from ioremap() areas. So we
> had to remove the domain switching. We also gained a dedicated TLS
> register.

Indeed.  On pre-ARMv6, we have the following choices for protection
attributes:

Page tables	Control Reg	Privileged	User
AP		S,R		permission	permission
00		0,0		No access	No access
00		1,0		Read-only	No access
00		0,1		Read-only	Read-only
00		1,1		Unpredictable	Unpredictable
01		X,X		Read/Write	No access
10		X,X		Read/Write	Read-only
11		X,X		Read/Write	Read/Write

We use S,R=1,0 under Linux because this allows us to read-protect
kernel pages without making them visible to userspace.  If we
changed to S,R=0,1, then we could have our read-only permissions
for both kernel and userspace, drop domain switching, and use the
plain LDR/STR instructions, but we then lose the ability to
write-protect module executable code and other parts of kernel
space without making them visible to userspace.

So, it essentially boils down to making a choice - which set of
security features we think are the most important.

> I think uaccess_enable() could indeed switch the kernel domain if
> KERNEL_DS is set and move this out of set_fs(). It would reduce the
> window the kernel domain permissions are overridden. Anyway,
> uaccess_enable() appeared much later on arm when Russell introduced PAN
> (SMAP) like support by switching the user domain.

Yes, that would be a possibility.  Another possibility would be to
eliminate as much usage of KERNEL_DS as possible - I've just found
one instance in sys_oabi-compat.c that can be eliminated (epoll_ctl)
but there's several there that can't with the current code structure,
and re-coding the contents of some fs/* functions to work around that
is a very bad idea.  If there's some scope for rejigging some of the
fs/* code, it may be possible to elimate some other cases in there.

I notice that the fs/* code seems like some of the last remaining
users of KERNEL_DS, although I suspect that some aren't possible to
eliminate. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
