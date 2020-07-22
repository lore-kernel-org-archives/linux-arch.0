From: Alex Belits <abelits-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 13/13] task_isolation: kick_all_cpus_sync: don't kick isolated
 cpus
Date: Wed, 22 Jul 2020 14:59:55 +0000
Message-ID: <5d0088ffd762b266124dfa5da9bcef0d9ddbae96.camel@marvell.com>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <04be044c1bcd76b7438b7563edc35383417f12c8.camel-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Content-ID: <7BED713CFA78E1408C46F0C24DF285EE-WIijndS0fTycE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Prasun Kapoor <pkapoor-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpNYWtlIHN1cmUgdGhhdCBr
aWNrX2FsbF9jcHVzX3N5bmMoKSBkb2VzIG5vdCBjYWxsIENQVXMgdGhhdCBhcmUgcnVubmluZw0K
aXNvbGF0ZWQgdGFza3MuDQoNClNpZ25lZC1vZmYtYnk6IFl1cmkgTm9yb3YgPHlub3JvdkBtYXJ2
ZWxsLmNvbT4NClthYmVsaXRzQG1hcnZlbGwuY29tOiB1c2Ugc2FmZSB0YXNrX2lzb2xhdGlvbl9j
cHVtYXNrKCkgaW1wbGVtZW50YXRpb25dDQpTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbGl0cyA8YWJl
bGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGtlcm5lbC9zbXAuYyB8IDE0ICsrKysrKysrKysrKyst
DQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zbXAuYyBiL2tlcm5lbC9zbXAuYw0KaW5kZXggNmE2ODQ5NzgzOTQ4
Li5mZjBkOTVkYjMzYjMgMTAwNjQ0DQotLS0gYS9rZXJuZWwvc21wLmMNCisrKyBiL2tlcm5lbC9z
bXAuYw0KQEAgLTgwMyw5ICs4MDMsMjEgQEAgc3RhdGljIHZvaWQgZG9fbm90aGluZyh2b2lkICp1
bnVzZWQpDQogICovDQogdm9pZCBraWNrX2FsbF9jcHVzX3N5bmModm9pZCkNCiB7DQorCXN0cnVj
dCBjcHVtYXNrIG1hc2s7DQorDQogCS8qIE1ha2Ugc3VyZSB0aGUgY2hhbmdlIGlzIHZpc2libGUg
YmVmb3JlIHdlIGtpY2sgdGhlIGNwdXMgKi8NCiAJc21wX21iKCk7DQotCXNtcF9jYWxsX2Z1bmN0
aW9uKGRvX25vdGhpbmcsIE5VTEwsIDEpOw0KKw0KKwlwcmVlbXB0X2Rpc2FibGUoKTsNCisjaWZk
ZWYgQ09ORklHX1RBU0tfSVNPTEFUSU9ODQorCWNwdW1hc2tfY2xlYXIoJm1hc2spOw0KKwl0YXNr
X2lzb2xhdGlvbl9jcHVtYXNrKCZtYXNrKTsNCisJY3B1bWFza19jb21wbGVtZW50KCZtYXNrLCAm
bWFzayk7DQorI2Vsc2UNCisJY3B1bWFza19zZXRhbGwoJm1hc2spOw0KKyNlbmRpZg0KKwlzbXBf
Y2FsbF9mdW5jdGlvbl9tYW55KCZtYXNrLCBkb19ub3RoaW5nLCBOVUxMLCAxKTsNCisJcHJlZW1w
dF9lbmFibGUoKTsNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoa2lja19hbGxfY3B1c19zeW5jKTsN
CiANCi0tIA0KMi4yNi4yDQoNCg==
