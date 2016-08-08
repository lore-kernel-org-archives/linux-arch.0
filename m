Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49857 "EHLO
	mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752184AbcHHQDx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2016 12:03:53 -0400
From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v7 0/4] improvements to the nmi_backtrace code
Date: Mon,  8 Aug 2016 12:03:34 -0400
Message-ID: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <20160808160334.CSmnznS8HxDFhieZOzfpj0K9Ls-Ts1y2GEJykTs-cPE@z>

This is a rebase of the v6 series onto v4.8-rc1, plus some changes
from Petr Mladek's review this morning.
