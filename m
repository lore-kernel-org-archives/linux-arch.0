From: Alex Belits <abelits-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 08/12] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Date: Sun, 8 Mar 2020 03:53:35 +0000
Message-ID: <0b4615be96008d1031efd3ed309437c05d564019.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Content-ID: <12BFA578C199064E880E6064C4B51C83-WIijndS0fTycE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prasun Kapoor <pkapoor-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpGb3Igbm9oel9mdWxsIENQ
VXMgdGhlIGRlc2lyYWJsZSBiZWhhdmlvciBpcyB0byByZWNlaXZlIGludGVycnVwdHMNCmdlbmVy
YXRlZCBieSB0aWNrX25vaHpfZnVsbF9raWNrX2NwdSgpLiBCdXQgZm9yIGhhcmQgaXNvbGF0aW9u
IGl0J3MNCm9idmlvdXNseSBub3QgZGVzaXJhYmxlIGJlY2F1c2UgaXQgYnJlYWtzIGlzb2xhdGlv
bi4NCg0KVGhpcyBwYXRjaCBhZGRzIGNoZWNrIGZvciBpdC4NCg0KU2lnbmVkLW9mZi1ieTogWXVy
aSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KW2FiZWxpdHNAbWFydmVsbC5jb206IHVwZGF0
ZWQsIG9ubHkgZXhjbHVkZSBDUFVzIHJ1bm5pbmcgaXNvbGF0ZWQgdGFza3NdDQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IEJlbGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGtlcm5lbC90aW1l
L3RpY2stc2NoZWQuYyB8IDMgKystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL3RpbWUvdGljay1zY2hlZC5jIGIv
a2VybmVsL3RpbWUvdGljay1zY2hlZC5jDQppbmRleCAxZDRkZWM5ZDNlZTcuLmZlNDUwM2JhMTMx
NiAxMDA2NDQNCi0tLSBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYw0KKysrIGIva2VybmVsL3Rp
bWUvdGljay1zY2hlZC5jDQpAQCAtMjAsNiArMjAsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9zY2hl
ZC9jbG9jay5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hlZC9zdGF0Lmg+DQogI2luY2x1ZGUgPGxp
bnV4L3NjaGVkL25vaHouaD4NCisjaW5jbHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogI2luY2x1
ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnFfd29yay5oPg0KICNpbmNs
dWRlIDxsaW51eC9wb3NpeC10aW1lcnMuaD4NCkBAIC0yNjIsNyArMjYzLDcgQEAgc3RhdGljIHZv
aWQgdGlja19ub2h6X2Z1bGxfa2ljayh2b2lkKQ0KICAqLw0KIHZvaWQgdGlja19ub2h6X2Z1bGxf
a2lja19jcHUoaW50IGNwdSkNCiB7DQotCWlmICghdGlja19ub2h6X2Z1bGxfY3B1KGNwdSkpDQor
CWlmICghdGlja19ub2h6X2Z1bGxfY3B1KGNwdSkgfHwgdGFza19pc29sYXRpb25fb25fY3B1KGNw
dSkpDQogCQlyZXR1cm47DQogDQogCWlycV93b3JrX3F1ZXVlX29uKCZwZXJfY3B1KG5vaHpfZnVs
bF9raWNrX3dvcmssIGNwdSksIGNwdSk7DQotLSANCjIuMjAuMQ0KDQo=
