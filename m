From: David Rientjes <rientjes@google.com>
Subject: [patch 5/8] block: rename CONFIG_EMBEDDED to CONFIG_EXPERT
Date: Wed, 29 Dec 2010 20:02:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1012292001050.27241@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

CONFIG_EMBEDDED has been renamed to CONFIG_EXPERT, so fix it in the
block/ directory.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 block/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -2,7 +2,7 @@
 # Block layer core configuration
 #
 menuconfig BLOCK
-       bool "Enable the block layer" if EMBEDDED
+       bool "Enable the block layer" if EXPERT
        default y
        help
 	 Provide block layer support for the kernel.
