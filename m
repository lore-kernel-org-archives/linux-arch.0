From: Andi Kleen <andi@firstfloor.org>
Subject: RFC: Use single pass kallsyms
Date: Fri,  9 Aug 2013 09:03:16 -0700
Message-ID: <1376064199-8296-1-git-send-email-andi@firstfloor.org>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, david.daney@cavium.com
List-Id: linux-arch.vger.kernel.org

This is my attempt to avoid extra link steps for kallsyms.

Originally for LTO (where it gives dramatic build time improvements),
but it also gives a nice build speedup on a standard build (-10s on my laptop)

Even with this we still link two times (one more for modpost), but this
may be eventually fixable too.

Right now this is an RFC, I'm particularly interested in testing
on more architectures.

