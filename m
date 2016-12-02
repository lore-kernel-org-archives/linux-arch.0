From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC, PATCH, v3.9] default exported asm symbols to zero
Date: Fri, 02 Dec 2016 13:40:27 +0100
Message-ID: <8452191.39CeLIHTBT@wuerfel>
References: <20161129131922.GA31466@angband.pl> <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com> <14455987.OWjnZpEEup@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <14455987.OWjnZpEEup@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

With binutils-2.16 and before, a weak missing symbol was kept during the
final link, and a missing CRC for an export would lead to that CRC
being treated as zero implicitly. With binutils-2.17, the crc
symbol gets dropped, and any module trying to use it will fail to
load.

This sets the weak CRC symbol to zero explicitly, making it defined
in vmlinux, which in turn lets us load the modules referring to
that CRC.

The comment above the __CRC_SYMBOL macro suggests that this was
always the intention, although it also seems that all symbols
defined in C have a correct CRC these days, and only the exports
that are now done in assembly need this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if this is the correct way of doing it, but this seems trivial
enough and lets me build the kernel with missing CRCs with any binutils
version.

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 63554e9..59a3b2f 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -54,6 +54,7 @@ KSYM(__kstrtab_\name):
 KSYM(__kcrctab_\name):
 	__put KSYM(__crc_\name)
 	.weak KSYM(__crc_\name)
+	.set KSYM(__crc_\name), 0
 	.previous
 #endif
 #endif

