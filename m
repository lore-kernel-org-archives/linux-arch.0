Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49507 "EHLO
	mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752375AbcGNUup (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2016 16:50:45 -0400
From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v6 0/4] improvements to the nmi_backtrace code
Date: Thu, 14 Jul 2016 16:50:28 -0400
Message-ID: <1468529432-28026-1-git-send-email-cmetcalf@mellanox.com>
In-Reply-To: <96e5ba5b-d8c2-42cd-11a3-ffebd85522c3@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <20160714205028.angZXhZVaGX5qJ_yZsdE2O_4gtCYWOkVWp4sN_EBTGI@z>

This is a straight rebasing of the v5 series onto v4.7-rc7, plus
I now show Aaron Tomlin's ack for patch 2/4, and review of patch 1/4.
