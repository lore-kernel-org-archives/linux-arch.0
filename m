From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v2 00/12] "Task_isolation" mode
Date: Sun, 8 Mar 2020 03:42:51 +0000
Message-ID: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:31686 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbgCHDn7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Mar 2020 22:43:59 -0500
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Content-Language: en-US
Content-ID: <ACC41A63E97F9F4C9AB5136C731F89B3@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>

VGhpcyBpcyB0aGUgdXBkYXRlZCB2ZXJzaW9uIG9mIHRhc2sgaXNvbGF0aW9uIHBhdGNoc2V0Lg0K
DQoxLiBDb21taXQgbWVzc2FnZXMgdXBkYXRlZCB0byBtYXRjaCBjaGFuZ2VzLg0KMi4gU2lnbi1v
ZmYgbGluZXMgcmVzdG9yZWQgZnJvbSBvcmlnaW5hbCBwYXRjaGVzLCBjaGFuZ2VzIGxpc3RlZCB3
aGVyZXZlciBhcHBsaWNhYmxlLg0KMy4gYXJtIHBsYXRmb3JtIC0tIGFkZGVkIG1pc3NpbmcgY2Fs
bHMgdG8gc3lzY2FsbCBjaGVjayBhbmQgY2xlYW51cCBwcm9jZWR1cmUgYWZ0ZXIgbGVhdmluZyBp
c29sYXRpb24uDQo0LiB4ODYgcGxhdGZvcm0gLS0gYWRkZWQgbWlzc2luZyBjYWxscyB0byBjbGVh
bnVwIHByb2NlZHVyZSBhZnRlciBsZWF2aW5nIGlzb2xhdGlvbi4NCg0K
