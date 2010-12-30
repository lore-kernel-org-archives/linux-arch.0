Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:38135 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0L3ECv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Dec 2010 23:02:51 -0500
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id oBU42oYW004113
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:50 -0800
Received: from pwj8 (pwj8.prod.google.com [10.241.219.72])
	by kpbe17.cbf.corp.google.com with ESMTP id oBU42mK7025945
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:49 -0800
Received: by pwj8 with SMTP id 8so1933148pwj.22
        for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:48 -0800 (PST)
Date: Wed, 29 Dec 2010 20:02:46 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: [patch 5/8] block: rename CONFIG_EMBEDDED to CONFIG_EXPERT
In-Reply-To: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.00.1012292001050.27241@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20101230040246.q_xtfIUIfFewhPRYHTSit9Bj9Qt0OQIcxtqxf-Yyujs@z>

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
