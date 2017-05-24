Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164077AbdEXNtf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 May 2017 09:49:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Subject: Re: Unify the various copies of libgcc into lib
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23395.1495633764.1@warthog.procyon.org.uk>
Date: Wed, 24 May 2017 14:49:24 +0100
Message-ID: <23396.1495633764@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dhowells@redhat.com, monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170524134924.F_pRjZd0a_8AM-UqzrxaoCAQpuUGz52C_xU0LXWUTa4@z>

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> ... Unfortunately I don't actually have all these cross compilers setup...

If you have Fedora, you have the following available as standard RPMs:

	gcc-aarch64-linux-gnu
	gcc-alpha-linux-gnu
	gcc-arm-linux-gnu
	gcc-avr32-linux-gnu
	gcc-bfin-linux-gnu
	gcc-c6x-linux-gnu
	gcc-cris-linux-gnu
	gcc-frv-linux-gnu
	gcc-h8300-linux-gnu
	gcc-hppa-linux-gnu
	gcc-hppa64-linux-gnu
	gcc-ia64-linux-gnu
	gcc-m32r-linux-gnu
	gcc-m68k-linux-gnu
	gcc-microblaze-linux-gnu
	gcc-mips64-linux-gnu
	gcc-mn10300-linux-gnu
	gcc-nios2-linux-gnu
	gcc-powerpc64-linux-gnu
	gcc-ppc64-linux-gnu
	gcc-s390x-linux-gnu
	gcc-sh-linux-gnu
	gcc-sparc64-linux-gnu
	gcc-tile-linux-gnu
	gcc-xtensa-linux-gnu

They're built from the same sources as the gcc rpm (and the matching binutils
cross rpms are built from the same sources as the binutils rpm) - it's only
the spec file that's different, and they lag a bit behind the core
gcc/binutils as they only get updated after those change.

So in Fedora 25 these are all gcc-6 and in Fedora 26 they're all gcc-7.

David
