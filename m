From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v4 00/13] "Task_isolation" mode
Date: Wed, 22 Jul 2020 14:44:38 +0000
Message-ID: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:4446 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728405AbgGVOpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 10:45:34 -0400
Content-Language: en-US
Content-ID: <9D5F23F66C03DB45B2B52ED1271588B2@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

VGhpcyBpcyBhIG5ldyB2ZXJzaW9uIG9mIHRhc2sgaXNvbGF0aW9uIGltcGxlbWVudGF0aW9uLiBQ
cmV2aW91cyB2ZXJzaW9uIGlzIGF0DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzA3YzI1
YzI0NmM1NTAxMjk4MWVjMDI5NmVlZTIzZTY4YzcxOTMzM2EuY2FtZWxAbWFydmVsbC5jb20vDQoN
Ck1vc3RseSB0aGlzIGNvdmVycyByYWNlIGNvbmRpdGlvbnMgcHJldmVudGlvbiBvbiBicmVha2lu
ZyBpc29sYXRpb24uIEVhcmx5IGFmdGVyIGtlcm5lbCBlbnRyeSwNCnRhc2tfaXNvbGF0aW9uX2Vu
dGVyKCkgaXMgY2FsbGVkIHRvIHVwZGF0ZSBmbGFncyB2aXNpYmxlIHRvIG90aGVyIENQVSBjb3Jl
cyBhbmQgdG8gcGVyZm9ybQ0Kc3luY2hyb25pemF0aW9uIGlmIG5lY2Vzc2FyeS4gQmVmb3JlIHRo
aXMgY2FsbCBvbmx5ICJzYWZlIiBvcGVyYXRpb25zIGhhcHBlbiwgYXMgbG9uZyBhcw0KQ09ORklH
X1RSQUNFX0lSUUZMQUdTIGlzIG5vdCBlbmFibGVkLg0KDQpUaGlzIGlzIGFsc28gaW50ZW5kZWQg
Zm9yIGZ1dHVyZSBUTEIgaGFuZGxpbmcgLS0gdGhlIGlkZWEgaXMgdG8gYWxzbyBpc29sYXRlIHRo
b3NlIENQVSBjb3JlcyBmcm9tDQpUTEIgZmx1c2hlcyB3aGlsZSB0aGV5IGFyZSBydW5uaW5nIGlz
b2xhdGVkIHRhc2sgaW4gdXNlcnNwYWNlLCBhbmQgZG8gb25lIGZsdXNoIG9uIGV4aXRpbmcsIGJl
Zm9yZQ0KYW55IGNvZGUgaXMgY2FsbGVkIHRoYXQgbWF5IHRvdWNoIGFueXRoaW5nIHVwZGF0ZWQu
DQoNClRoZSBmdW5jdGlvbmFsaXR5IGFuZCBpbnRlcmZhY2UgaXMgdW5jaGFuZ2VkLCBleGNlcHQg
Zm9yIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2lzb2xhdGlvbl9ydW5uaW5nDQpjb250YWluaW5n
IHRoZSBsaXN0IG9mIENQVXMgcnVubmluZyBpc29sYXRlZCB0YXNrcy4gVGhpcyBzaG91bGQgYmUg
dXNlZnVsIGZvciB1c2Vyc3BhY2UgaGVscGVyDQpsaWJyYXJpZXMuDQo=
