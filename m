From: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Tue, 9 Aug 2016 09:20:16 +0930
Message-ID: <20160808235016.GD20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <12986071.MeSB5hmlsH@wuerfel>
 <20160807234947.GV20904@bubble.grove.modra.org>
 <1882847.dG563Vieov@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36607 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbcHHXuW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2016 19:50:22 -0400
Content-Disposition: inline
In-Reply-To: <1882847.dG563Vieov@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On Mon, Aug 08, 2016 at 05:14:27PM +0200, Arnd Bergmann wrote:
> I have reverted that patch now, so ARM uses ".fixup" again like every
> other architecture does, and now "*(.fixup) *(.text .text.*)" works
> correctly, while ""*(.fixup) *(.text .fixup .text.*)" also fails
> the same way that I saw before:

That is really odd.  The linker isn't supposed to treat those script
snippets differently.  First match for .fixup wins.

$ cat > fixup1.s <<\EOF
 .global _start
 .text
_start:
 .dc.a .L2
.L1:
 .section ".fixup","ax",%progbits
.L2:
 .dc.a .L1
EOF
$ cat > fixup2.s <<\EOF
 .section ".text.xyz","ax",%progbits
 .dc.a .L2
.L1:

 .section ".fixup","ax",%progbits
.L2:
 .dc.a .L1
EOF
$ cat > fixup.lnk <<\EOF
SECTIONS {
  .text : { *(.fixup) *(.text .fixup .text.*) }
}
EOF
$ as -o fixup1.o fixup1.s 
$ as -o fixup2.o fixup2.s 
$ ld -o fixup -T fixup.lnk -Map fixup.map fixup1.o fixup2.o
$ cat fixup.map

Memory Configuration

Name             Origin             Length             Attributes
*default*        0x0000000000000000 0xffffffffffffffff

Linker script and memory map


.text           0x0000000000000000       0x10
 *(.fixup)
 .fixup         0x0000000000000000        0x4 fixup1.o
 .fixup         0x0000000000000004        0x4 fixup2.o
 *(.text .fixup .text.*)
 .text          0x0000000000000008        0x4 fixup1.o
                0x0000000000000008                _start
 .text          0x000000000000000c        0x0 fixup2.o
 .text.xyz      0x000000000000000c        0x4 fixup2.o
[snip]

-- 
Alan Modra
Australia Development Lab, IBM
