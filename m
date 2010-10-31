From: "Alexander van Heukelum" <heukelum@fastmail.fm>
Subject: Re: [PATCH] Partially revert patch that encloses asm-offset.h numbers
 in brackets
Date: Sun, 31 Oct 2010 16:29:03 +0100
Message-ID: <1288538943.19875.1402847217@webmail.messagingengine.com>
References: <4CC5B1A1020000780001EF7C@vpn.id2.novell.com><20101025140218.5092.74117.stgit@warthog.procyon.org.uk><28707.1288018465@redhat.com>
 <4CC5B8D3020000780001EFB4@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57478 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756031Ab0JaP3F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 31 Oct 2010 11:29:05 -0400
In-Reply-To: <4CC5B8D3020000780001EFB4@vpn.id2.novell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@linux.intel.com>, torvalds@osdl.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Mon, 25 Oct 2010 16:05 +0100, "Jan Beulich" <JBeulich@novell.com> wr=
ote:
> >>> On 25.10.10 at 16:54, David Howells <dhowells@redhat.com> wrote:
> > Jan Beulich <JBeulich@novell.com> wrote:
> >=20
> >> Isn't this a gas bug then? Anywhere you use a plain number you
> >> should also be permitted to use an expression.
> >=20
> > Whoever defined the gas assembly syntax for binutils specified that=
 (N) as=20
> > an
> > operand defines an absolute address and N defines an immediate valu=
e.
> >=20
> > However, prefixing an expression with a unary plus works for me, so=
 adding
> > this into my patch:
> >=20
> > -	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:;=
 \
> > +	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 +(\2) /* \3 *=
/:; \
> >=20
> > Does that work for you?
>=20
> Alexander, you seem to be having access to a worst case system -
> could you give this a try?

Hi all!

I'm just back from a week of vacation, so I missed the discussion compl=
etely.

I didn't check the version with the plus-sign, but the current state in=
 linus' tree
compiles fine(*) with this ubuntu 6.06 image. So I'ld suggest to clean =
up the
sed-script to the old version and limp on a few more kernel versions, w=
atch out
for checkpatch-improvements, and then try again to deprecate gas-2.16, =
notify
Andrew Morton he should get rid of it, and clean up the space-removals =
again.

(*) First try was with a UP-PREEMPT-mini.config and this one ended with=
:
In file included from /home/src/linux/linux-2.6/arch/x86/include/asm/su=
spend_32.h:10,
                 from /home/src/linux/linux-2.6/arch/x86/include/asm/su=
spend.h:2,
                 from /home/src/linux/linux-2.6/arch/x86/kernel/asm-off=
sets_32.c:21,
                 from /home/src/linux/linux-2.6/arch/x86/kernel/asm-off=
sets.c:2:
/home/src/linux/linux-2.6/arch/x86/include/asm/i387.h: In function =E2=80=
=98irq_ts_save=E2=80=99:
/home/src/linux/linux-2.6/arch/x86/include/asm/i387.h:325: error: impli=
cit declaration of function =E2=80=98kernel_locked=E2=80=99
make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1

Not sure if this is already known. Configuration:

The mini.config file:

CONFIG_EXPERIMENTAL=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_RCU_FANOUT=3D32
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D"../initramfs.i386"
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_EMBEDDED=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_CC_STACKPROTECTOR=3Dy
CONFIG_HZ_100=3Dy
CONFIG_RELOCATABLE=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_NET=3Dy
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_PROC_FS=3Dy
CONFIG_SYSFS=3Dy
CONFIG_FRAME_WARN=3D196
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_X86_VERBOSE_BOOTUP=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DEBUG_RODATA=3Dy
CONFIG_OPTIMIZE_INLINING=3Dy

(can be expanded with "make KCONFIG_ALLCONFIG=3Dmini.config allnoconfig=
")

Removing CONFIG_PREEMPT=3Dy got things going.

Greetings,
   Alexander

> Thanks, Jan
>=20
