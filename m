Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0080.outbound.protection.outlook.com ([157.55.234.80]:36961
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759722AbcDERmn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Apr 2016 13:42:43 -0400
From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v5 0/4] improvements to the nmi_backtrace code
Date: Tue, 5 Apr 2016 13:26:44 -0400
Message-ID: <1459877208-15119-1-git-send-email-cmetcalf@mellanox.com>
In-Reply-To: <201604031905.WLWlnyKg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <20160405172644.JQqmzRn1tshblmZccuIPAPjv1ulCAcfICG6ByEIQ2rA@z>

This is just a one-line change to the v4 series, to catch the new arm
vmlinux-xip.lds.S file, which I missed when I rebased to 4.6 for v4
(my arm config for testing did not include CONFIG_XIP_KERNEL).
Thanks to Fengguang Wu and the 0-day test robot for that.

Whose tree would this go through?  I have an ack for Peter Z for
patch 4/4 and no other feedback for patches 1/4 or 2/4; I can
certainly push 3/4 through the tile tree myself if that helps, though
my guess is keeping it with the rest of the series makes more sense
for tile since it doesn't lose any functionality that way.
