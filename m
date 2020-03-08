From: Alex Belits <abelits-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 09/12] task_isolation: net: don't flush backlog on CPUs
 running isolated tasks
Date: Sun, 8 Mar 2020 03:54:32 +0000
Message-ID: <541d4f371541b5085fb3519ae749d9ed8f056aeb.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Content-ID: <4C9919D0E1E70145A8395AD0A6D070D1-WIijndS0fTycE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prasun Kapoor <pkapoor-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

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
