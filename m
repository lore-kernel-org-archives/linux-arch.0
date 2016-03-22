Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0059.outbound.protection.outlook.com ([157.56.112.59]:45698
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755414AbcCVRfT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Mar 2016 13:35:19 -0400
From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v3 0/4] improvements to the nmi_backtrace code
Date: Tue, 22 Mar 2016 13:19:35 -0400
Message-ID: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com>
In-Reply-To: <20160321214935.GF6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <20160322171935.5rIRIau4f5Pg9T6LTj_ItxHUiWiINJvhIra85tbCQcE@z>
