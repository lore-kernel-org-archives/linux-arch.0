From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Mon, 30 Jan 2017 14:51:51 +0000
Message-ID: <20170130145151.GW27312@n2100.armlinux.org.uk>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
Sender: linux-kbuild-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, slash.tmp@free.fr, daniel.vetter@ffwll.ch, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 23, 2017 at 05:52:45PM +0100, Borislav Petkov wrote:
> On Mon, Jan 23, 2017 at 03:58:37PM +0100, Nicolas Dichtel wrote:
> > This header file is exported, thus move it to uapi.
> 
> Why? Why is this damn thing exported in the first place?
> 
> The moment we decide to change an MSR name or even remove it from that
> file, we break userspace. And what for, because userspace is using some
> arbitrary header file which was meant to be for the kernel solely.
> 
> NAKed-by: Borislav Petkov <bp@suse.de>

Here on my Fedora system:

$ less /usr/include/asm/msr-index.h
#ifndef _ASM_X86_MSR_INDEX_H
#define _ASM_X86_MSR_INDEX_H

/* CPU model specific register (MSR) numbers */

/* x86-64 specific MSRs */
#define MSR_EFER                0xc0000080 /* extended feature register */
#define MSR_STAR                0xc0000081 /* legacy mode SYSCALL target */
#define MSR_LSTAR               0xc0000082 /* long mode SYSCALL target */
...

Like it or not, it is _already_ exported to userspace, so it forms
part of the user ABI.  You can try to remove it from userspace view,
but if anyone has already started to use it, removing it will already
cause a userspace regression.

So, I don't think we have any grounds to NAK these patches on the
basis of "we don't want this to be visible to userspace because it
may cause a userspace regression."  Removing it from userspace view
is likely to cause a userspace regression.

This patch just makes sure that such a regression doesn't happen when
kbuild stops exporting files in _non_-uapi directories.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
