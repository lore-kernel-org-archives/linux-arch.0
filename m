Return-Path: <SRS0=ngws=BB=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1568 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732673AbgGVO6y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 10:58:54 -0400
From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v4 11/13] task_isolation: net: don't flush backlog on CPUs
 running isolated tasks
Date: Wed, 22 Jul 2020 14:58:24 +0000
Message-ID: <01470cf1f1a2e79e46a87bb5a8a4780a1c3cc740.camel@marvell.com>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
In-Reply-To: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <392AE7C4E756DC44BB5350C22441BE67@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <20200722145824.G08cHAAFVA9yXPMihHRtf8yo-Kphp_qs3h8gz4V25tc@z>

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpJZiBDUFUgcnVucyBpc29s
YXRlZCB0YXNrLCB0aGVyZSdzIG5vIGFueSBiYWNrbG9nIG9uIGl0LCBhbmQNCnNvIHdlIGRvbid0
IG5lZWQgdG8gZmx1c2ggaXQuIEN1cnJlbnRseSBmbHVzaF9hbGxfYmFja2xvZ3MoKQ0KZW5xdWV1
ZXMgY29ycmVzcG9uZGluZyB3b3JrIG9uIGFsbCBDUFVzIGluY2x1ZGluZyBvbmVzIHRoYXQgcnVu
DQppc29sYXRlZCB0YXNrcy4gSXQgbGVhZHMgdG8gYnJlYWtpbmcgdGFzayBpc29sYXRpb24gZm9y
IG5vdGhpbmcuDQoNCkluIHRoaXMgcGF0Y2gsIGJhY2tsb2cgZmx1c2hpbmcgaXMgZW5xdWV1ZWQg
b25seSBvbiBub24taXNvbGF0ZWQgQ1BVcy4NCg0KU2lnbmVkLW9mZi1ieTogWXVyaSBOb3JvdiA8
eW5vcm92QG1hcnZlbGwuY29tPg0KW2FiZWxpdHNAbWFydmVsbC5jb206IHVzZSBzYWZlIHRhc2tf
aXNvbGF0aW9uX29uX2NwdSgpIGltcGxlbWVudGF0aW9uXQ0KU2lnbmVkLW9mZi1ieTogQWxleCBC
ZWxpdHMgPGFiZWxpdHNAbWFydmVsbC5jb20+DQotLS0NCiBuZXQvY29yZS9kZXYuYyB8IDcgKysr
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMNCmluZGV4IDkwYjU5
ZmM1MGRjOS4uODNhMjgyZjc0NTNkIDEwMDY0NA0KLS0tIGEvbmV0L2NvcmUvZGV2LmMNCisrKyBi
L25ldC9jb3JlL2Rldi5jDQpAQCAtNzQsNiArNzQsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9jcHUu
aD4NCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
DQorI2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9oYXNoLmg+
DQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4NCkBA
IC01NjI0LDkgKzU2MjUsMTMgQEAgc3RhdGljIHZvaWQgZmx1c2hfYWxsX2JhY2tsb2dzKHZvaWQp
DQogDQogCWdldF9vbmxpbmVfY3B1cygpOw0KIA0KLQlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkN
CisJc21wX3JtYigpOw0KKwlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KKwkJaWYgKHRhc2tf
aXNvbGF0aW9uX29uX2NwdShjcHUpKQ0KKwkJCWNvbnRpbnVlOw0KIAkJcXVldWVfd29ya19vbihj
cHUsIHN5c3RlbV9oaWdocHJpX3dxLA0KIAkJCSAgICAgIHBlcl9jcHVfcHRyKCZmbHVzaF93b3Jr
cywgY3B1KSk7DQorCX0NCiANCiAJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpDQogCQlmbHVzaF93
b3JrKHBlcl9jcHVfcHRyKCZmbHVzaF93b3JrcywgY3B1KSk7DQotLSANCjIuMjYuMg0KDQo=
