From: Alex Belits <abelits@marvell.com>
Subject: [PATCH 09/12] task_isolation: net: don't flush backlog on CPUs
 running isolated tasks
Date: Wed, 4 Mar 2020 16:13:32 +0000
Message-ID: <fe14905b3ba8501d0120c29483fc2780a2b86517.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50422 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgCDQN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:13:58 -0500
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Content-Language: en-US
Content-ID: <35F281CA22FE5D4C8E7A7D853F5CF0C5@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpJZiBDUFUgcnVucyBpc29s
YXRlZCB0YXNrLCB0aGVyZSdzIG5vIGFueSBiYWNrbG9nIG9uIGl0LCBhbmQNCnNvIHdlIGRvbid0
IG5lZWQgdG8gZmx1c2ggaXQuIEN1cnJlbnRseSBmbHVzaF9hbGxfYmFja2xvZ3MoKQ0KZW5xdWV1
ZXMgY29ycmVzcG9uZGluZyB3b3JrIG9uIGFsbCBDUFVzIGluY2x1ZGluZyBvbmVzIHRoYXQgcnVu
DQppc29sYXRlZCB0YXNrcy4gSXQgbGVhZHMgdG8gYnJlYWtpbmcgdGFzayBpc29sYXRpb24gZm9y
IG5vdGhpbmcuDQoNCkluIHRoaXMgcGF0Y2gsIGJhY2tsb2cgZmx1c2hpbmcgaXMgZW5xdWV1ZWQg
b25seSBvbiBub24taXNvbGF0ZWQgQ1BVcy4NCg0KU2lnbmVkLW9mZi1ieTogQWxleCBCZWxpdHMg
PGFiZWxpdHNAbWFydmVsbC5jb20+DQotLS0NCiBuZXQvY29yZS9kZXYuYyB8IDYgKysrKystDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYw0KaW5kZXggYzZjOTg1ZmU3YjFi
Li42ZDMyYWJiMWYwNmQgMTAwNjQ0DQotLS0gYS9uZXQvY29yZS9kZXYuYw0KKysrIGIvbmV0L2Nv
cmUvZGV2LmMNCkBAIC03NCw2ICs3NCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KICNp
bmNsdWRlIDxsaW51eC90eXBlcy5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCisjaW5j
bHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogI2luY2x1ZGUgPGxpbnV4L2hhc2guaD4NCiAjaW5j
bHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KQEAgLTU1MTgs
OSArNTUxOSwxMiBAQCBzdGF0aWMgdm9pZCBmbHVzaF9hbGxfYmFja2xvZ3Modm9pZCkNCiANCiAJ
Z2V0X29ubGluZV9jcHVzKCk7DQogDQotCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KQ0KKwlmb3Jf
ZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KKwkJaWYgKHRhc2tfaXNvbGF0aW9uX29uX2NwdShjcHUp
KQ0KKwkJCWNvbnRpbnVlOw0KIAkJcXVldWVfd29ya19vbihjcHUsIHN5c3RlbV9oaWdocHJpX3dx
LA0KIAkJCSAgICAgIHBlcl9jcHVfcHRyKCZmbHVzaF93b3JrcywgY3B1KSk7DQorCX0NCiANCiAJ
Zm9yX2VhY2hfb25saW5lX2NwdShjcHUpDQogCQlmbHVzaF93b3JrKHBlcl9jcHVfcHRyKCZmbHVz
aF93b3JrcywgY3B1KSk7DQotLSANCjIuMjAuMQ0KDQo=
