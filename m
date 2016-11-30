From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 0/3] fix modversion for symbol exported from asm code
Date: Wed, 30 Nov 2016 03:50:21 -0500
Message-ID: <1480495824-4151-1-git-send-email-nicolas.pitre@linaro.org>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This is my alternative to asm-prototypes.h for fixing modversion with
assembly symbols. This preserves the goal of not having a central list
of symbols that may get out of sync wrt the actual code.

An example usage is provided for ARM.

The asm-prototypes.h method is still available for those who might
prefer it.

Given that modversion is currently broken, I'd advocate for the first
2 patches to go into mainline now even if v4.9 is imminent. That can't
make things any worse than they are, and with this in place people may
start fixing their own architecture.

