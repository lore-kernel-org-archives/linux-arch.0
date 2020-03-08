Return-Path: <SRS0=iRyw=4Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16808 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgCHDzD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Mar 2020 22:55:03 -0500
From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v2 09/12] task_isolation: net: don't flush backlog on CPUs
 running isolated tasks
Date: Sun, 8 Mar 2020 03:54:32 +0000
Message-ID: <541d4f371541b5085fb3519ae749d9ed8f056aeb.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
In-Reply-To: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C9919D0E1E70145A8395AD0A6D070D1@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Message-ID: <20200308035432.mAw82M-tO2nZ1W6xGcWuTgQ5sVbQhXJvskhuzhmXB4s@z>

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpJZiBDUFUgcnVucyBpc29s
YXRlZCB0YXNrLCB0aGVyZSdzIG5vIGFueSBiYWNrbG9nIG9uIGl0LCBhbmQNCnNvIHdlIGRvbid0
IG5lZWQgdG8gZmx1c2ggaXQuIEN1cnJlbnRseSBmbHVzaF9hbGxfYmFja2xvZ3MoKQ0KZW5xdWV1
ZXMgY29ycmVzcG9uZGluZyB3b3JrIG9uIGFsbCBDUFVzIGluY2x1ZGluZyBvbmVzIHRoYXQgcnVu
DQppc29sYXRlZCB0YXNrcy4gSXQgbGVhZHMgdG8gYnJlYWtpbmcgdGFzayBpc29sYXRpb24gZm9y
IG5vdGhpbmcuDQoNCkluIHRoaXMgcGF0Y2gsIGJhY2tsb2cgZmx1c2hpbmcgaXMgZW5xdWV1ZWQg
b25seSBvbiBub24taXNvbGF0ZWQgQ1BVcy4NCg0KU2lnbmVkLW9mZi1ieTogWXVyaSBOb3JvdiA8
eW5vcm92QG1hcnZlbGwuY29tPg0KW2FiZWxpdHNAbWFydmVsbC5jb206IHVzZSBzYWZlIHRhc2tf
aXNvbGF0aW9uX29uX2NwdSgpIGltcGxlbWVudGF0aW9uXQ0KU2lnbmVkLW9mZi1ieTogQWxleCBC
ZWxpdHMgPGFiZWxpdHNAbWFydmVsbC5jb20+DQotLS0NCiBuZXQvY29yZS9kZXYuYyB8IDYgKysr
KystDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYw0KaW5kZXggYzZjOTg1
ZmU3YjFiLi42ZDMyYWJiMWYwNmQgMTAwNjQ0DQotLS0gYS9uZXQvY29yZS9kZXYuYw0KKysrIGIv
bmV0L2NvcmUvZGV2LmMNCkBAIC03NCw2ICs3NCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2NwdS5o
Pg0KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4N
CisjaW5jbHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogI2luY2x1ZGUgPGxpbnV4L2hhc2guaD4N
CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KQEAg
LTU1MTgsOSArNTUxOSwxMiBAQCBzdGF0aWMgdm9pZCBmbHVzaF9hbGxfYmFja2xvZ3Modm9pZCkN
CiANCiAJZ2V0X29ubGluZV9jcHVzKCk7DQogDQotCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KQ0K
Kwlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KKwkJaWYgKHRhc2tfaXNvbGF0aW9uX29uX2Nw
dShjcHUpKQ0KKwkJCWNvbnRpbnVlOw0KIAkJcXVldWVfd29ya19vbihjcHUsIHN5c3RlbV9oaWdo
cHJpX3dxLA0KIAkJCSAgICAgIHBlcl9jcHVfcHRyKCZmbHVzaF93b3JrcywgY3B1KSk7DQorCX0N
CiANCiAJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpDQogCQlmbHVzaF93b3JrKHBlcl9jcHVfcHRy
KCZmbHVzaF93b3JrcywgY3B1KSk7DQotLSANCjIuMjAuMQ0KDQo=
