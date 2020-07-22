From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v4 05/13] task_isolation: Add xen-specific hook
Date: Wed, 22 Jul 2020 14:51:55 +0000
Message-ID: <f1de0a5f9b0ad9305030b452e9fdc5b39c7e54b4.camel@marvell.com>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
Content-Language: en-US
Content-ID: <B5764F27D073494DB2469C0D85F3B1A2@namprd18.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

eGVuX2V2dGNobl9kb191cGNhbGwoKSBzaG91bGQgY2FsbCB0YXNrX2lzb2xhdGlvbl9rZXJuZWxf
ZW50ZXIoKQ0KdG8gaW5kaWNhdGUgdGhhdCBpc29sYXRpb24gaXMgYnJva2VuIGFuZCBwZXJmb3Jt
IHN5bmNocm9uaXphdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogQWxleCBCZWxpdHMgPGFiZWxpdHNA
bWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyB8IDMg
KysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMgYi9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRz
X2Jhc2UuYw0KaW5kZXggMTQwYzdiZjMzYTk4Li40YzE2Y2Q1OGYzNmIgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KKysrIGIvZHJpdmVycy94ZW4vZXZlbnRz
L2V2ZW50c19iYXNlLmMNCkBAIC0zMyw2ICszMyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCiAjaW5jbHVkZSA8bGludXgvaXJxbnIuaD4NCiAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQor
I2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KIA0KICNpZmRlZiBDT05GSUdfWDg2DQogI2lu
Y2x1ZGUgPGFzbS9kZXNjLmg+DQpAQCAtMTIzNiw2ICsxMjM3LDggQEAgdm9pZCB4ZW5fZXZ0Y2hu
X2RvX3VwY2FsbChzdHJ1Y3QgcHRfcmVncyAqcmVncykNCiB7DQogCXN0cnVjdCBwdF9yZWdzICpv
bGRfcmVncyA9IHNldF9pcnFfcmVncyhyZWdzKTsNCiANCisJdGFza19pc29sYXRpb25fa2VybmVs
X2VudGVyKCk7DQorDQogCWlycV9lbnRlcigpOw0KIA0KIAlfX3hlbl9ldnRjaG5fZG9fdXBjYWxs
KCk7DQotLSANCjIuMjYuMg0KDQo=
