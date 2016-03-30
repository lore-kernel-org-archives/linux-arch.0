Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0081.outbound.protection.outlook.com ([157.55.234.81]:45024
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752794AbcC3Rtp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Mar 2016 13:49:45 -0400
From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v4 0/4] improvements to the nmi_backtrace code
Date: Wed, 30 Mar 2016 13:16:06 -0400
Message-ID: <1459358170-27745-1-git-send-email-cmetcalf@mellanox.com>
In-Reply-To: <8028886.DUEJzF47F1@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <20160330171606.rFXyL0_U56zZqclSMADaFBYCs-fwRC2N3gNB75YIBfk@z>
