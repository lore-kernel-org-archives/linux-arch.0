Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:42531 "EHLO
        5.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbcJJDk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2016 23:40:26 -0400
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 727A43907D
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2016 02:03:59 +0200 (CEST)
From: Joel Porquet <joel@porquet.org>
Subject: [PATCH 0/2] make asm-generic/futex.h usable for more arch ports
Date: Sun,  9 Oct 2016 17:03:06 -0700
Message-ID: <20161010000308.13212-1-joel@porquet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joel Porquet <joel@porquet.org>
Message-ID: <20161010000306.8uwGDBP_Rb6pRj390XcLX3PsE5WSj5m1w-9ZveaiTEQ@z>

Hi all,

I've had a patch on my shelf for a couple of years, from when I ported Linux on
a new processor architecture for an academic project, and thought I could send
it and let you decide if it's worth taking or not.

During my port, I basically modified the generic header "asm-generic/futex.h"
and made it into a more generic version so that I could include it in my code
and only redefine the necessary arch-specific bits.

Right now, most of the arch ports redefine their own "asm/futex.h" completely
although, for example for "futex_atomic_op_inuser()", they often share the exact
same preamble and epilogue and could benefit from some code refactoring.

My (short) series is made of two patches: 1/ refactoring "asm-generic/futex.h"
in order to make the arch-specific routines into overload-able macros that arch
ports can redefine when required, 2/ an example of how to use this refactoring
with the ARM port.

Let me know what you think.

Cheers,
Joël

Joel Porquet (2):
  asm-generic/futex.h: code refactoring
  arm: futex: Use asm-generic/futex.h instead of redefining the entire
    header

 arch/arm/include/asm/futex.h | 203 +++++++++++++++++----------------------
 include/asm-generic/futex.h  | 219 ++++++++++++++++++++++---------------------
 2 files changed, 196 insertions(+), 226 deletions(-)

-- 
2.10.0

