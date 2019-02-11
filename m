From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/2] Ensure inX() is ordered wrt delay() routines
Date: Mon, 11 Feb 2019 17:45:42 +0000
Message-ID: <20190211174544.4302-1-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi all,

Ordering port read accesses against non-memory-mapped clocksource reads can
require funky dependency code in conjunction with memory barriers. This isn't
possible to implement with the asm-generic definition of io.h, since the value
read from the device is not passed through to the underlying barrier macro and
therefore the dependency information is lost.

This series passes the value through and hooks up the fence on arm64.

Will

--->8

Will Deacon (2):
  asm-generic/io: Pass result on inX() accessor to __io_par()
  arm64: io: Hook up __io_par() for inX() ordering

 arch/arm64/include/asm/io.h | 1 +
 include/asm-generic/io.h    | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.11.0
