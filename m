From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Tue, 31 Jan 2017 17:21:33 +0100
Message-ID: <20170131162133.GA8258@gmail.com>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <20170130145151.GW27312@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170130145151.GW27312@n2100.armlinux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Borislav Petkov <bp@alien8.de>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, slash.tmp@free.fr, daniel.vetter@ffwll.ch, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-arch.vger.kernel.org


* Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Mon, Jan 23, 2017 at 05:52:45PM +0100, Borislav Petkov wrote:
> > On Mon, Jan 23, 2017 at 03:58:37PM +0100, Nicolas Dichtel wrote:
> > > This header file is exported, thus move it to uapi.
> > 
> > Why? Why is this damn thing exported in the first place?
> > 
> > The moment we decide to change an MSR name or even remove it from that
> > file, we break userspace. And what for, because userspace is using some
> > arbitrary header file which was meant to be for the kernel solely.
> > 
> > NAKed-by: Borislav Petkov <bp@suse.de>
> 
> Here on my Fedora system:
> 
> $ less /usr/include/asm/msr-index.h
> #ifndef _ASM_X86_MSR_INDEX_H
> #define _ASM_X86_MSR_INDEX_H
> 
> /* CPU model specific register (MSR) numbers */
> 
> /* x86-64 specific MSRs */
> #define MSR_EFER                0xc0000080 /* extended feature register */
> #define MSR_STAR                0xc0000081 /* legacy mode SYSCALL target */
> #define MSR_LSTAR               0xc0000082 /* long mode SYSCALL target */
> ...
> 
> Like it or not, it is _already_ exported to userspace, so it forms
> part of the user ABI.

Firstly, I believe you are (very!) confused about what forms part of the Linux 
user-space ABI - it's not the exported headers but the functionality and how 
application _binaries_ rely on it. We have strong ABI guarantees that are in no 
header anywhere. And we have tons and tons of details in UAPI headers that are not 
part of any system call ABI (or protocol ABI) of Linux.

Note that for example the 'MSR_STAR' definition you quote above is not part of the 
ABI, because user-space _cannot make use of it_: it's a privileged CPU register 
that only the kernel can write to. There's no system call ABI that Linux defines 
that this MSR (or any other MSR for that matter) are part of.

These MSR headers are not part of the ABI - they are part of the _mechanism_ 
trying to inform user-space about ABIs and people trying to somehow claim that 
they are an ABI are confused IMHO.

The point with msr-index.h is that there's no user-space ABI where those MSRs are 
enumerated.

Secondly, ABI means 'Application Binary Interface' - note the 'Binary' part. The 
ABI cannot be broken, by definition, by putting a header into another place. Now 
we do export UAPI headers and we definitely don't want to break user-space tooling 
if we can avoid it, but trying to spin the UAPI headers mechanism into an "ABI" is 
confused on so many levels.


I.e. this whole discussion is silly in the extreme. The point of the UAPI exports 
is to clean up our ABI exports, after we used to export _all_ headers to 
user-space.

I.e. by definition the UAPI mechanism is fundamentally about _restricting_ the 
amount of headers that are exposed - separating true ABI from random kernel 
internals. This process of enumerating ABI details separately from kernel 
implementation internal details improves the kernel headers.

> [...]  You can try to remove it from userspace view, but if anyone has already 
> started to use it, removing it will already cause a userspace regression.

I challenge you to show a single user-space regression from the removal of the 
'MSR_STAR' definition for example.

Please explain, why do you want to export msr-index.h and which part of it is an 
'ABI' in your opinion? Until you can explain that my NAK stands.

Thanks,

	Ingo
