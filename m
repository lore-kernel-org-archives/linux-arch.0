Return-Path: <SRS0=yGje=5Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47456 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbgDIP05 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 11:26:57 -0400
From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v3 10/13] task_isolation: net: don't flush backlog on CPUs
 running isolated tasks
Date: Thu, 9 Apr 2020 15:26:26 +0000
Message-ID: <ca337ff4e82a92d2fe22ce74232730eacfc74d96.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
         <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
In-Reply-To: <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <76EC25E45302BC4699A62EBA0CFD13EB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <20200409152626.qU_EsmfoarQ2zkhXfu4K3o3b18itk8w8QG5n8FeO58g@z>

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
ZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMNCmluZGV4IGM2Yzk4
NWZlN2IxYi4uMzUzZDJiZTM5MjAyIDEwMDY0NA0KLS0tIGEvbmV0L2NvcmUvZGV2LmMNCisrKyBi
L25ldC9jb3JlL2Rldi5jDQpAQCAtNzQsNiArNzQsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9jcHUu
aD4NCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
DQorI2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9oYXNoLmg+
DQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4NCkBA
IC01NTE4LDkgKzU1MTksMTMgQEAgc3RhdGljIHZvaWQgZmx1c2hfYWxsX2JhY2tsb2dzKHZvaWQp
DQogDQogCWdldF9vbmxpbmVfY3B1cygpOw0KIA0KLQlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkN
CisJc21wX3JtYigpOw0KKwlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KKwkJaWYgKHRhc2tf
aXNvbGF0aW9uX29uX2NwdShjcHUpKQ0KKwkJCWNvbnRpbnVlOw0KIAkJcXVldWVfd29ya19vbihj
cHUsIHN5c3RlbV9oaWdocHJpX3dxLA0KIAkJCSAgICAgIHBlcl9jcHVfcHRyKCZmbHVzaF93b3Jr
cywgY3B1KSk7DQorCX0NCiANCiAJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpDQogCQlmbHVzaF93
b3JrKHBlcl9jcHVfcHRyKCZmbHVzaF93b3JrcywgY3B1KSk7DQotLSANCjIuMjAuMQ0KDQo=
