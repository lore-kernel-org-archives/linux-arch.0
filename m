Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr770129.outbound.protection.outlook.com ([40.107.77.129]:44558
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfF1Sdy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 14:33:54 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v4 0/2] Drivers: hv: Move Hyper-V clock/timer code to separate
 clocksource driver
Date: Fri, 28 Jun 2019 18:33:50 +0000
Message-ID: <1561746758-23216-1-git-send-email-mikelley@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Cc: Michael Kelley <mikelley@microsoft.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, KY Srinivasan <kys@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "paul.burton@mips.com" <paul.burton@mips.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "salyzyn@android.com" <salyzyn@android.com>, "pcc@google.com" <pcc@google.com>, "shuah@kernel.org" <shuah@kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "huw@codeweavers.com" <huw@codeweavers.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Message-ID: <20190628183350.d5LA6E45y37p85Kcpz92lZAaQfKrSZli3ldFwinG-jk@z>

VGhpcyBwYXRjaCBzZXJpZXMgbW92ZXMgSHlwZXItViBjbG9jay90aW1lciBjb2RlIHRvIGEgc2Vw
YXJhdGUgSHlwZXItVg0KY2xvY2tzb3VyY2UgZHJpdmVyLiBQcmV2aW91c2x5LCBIeXBlci1WIGNs
b2NrL3RpbWVyIGNvZGUgYW5kIGRhdGENCnN0cnVjdHVyZXMgd2VyZSBtaXhlZCBpbiB3aXRoIG90
aGVyIEh5cGVyLVYgY29kZSBpbiB0aGUgSVNBIGluZGVwZW5kZW50DQpkcml2ZXJzL2h2IGNvZGUg
YXMgd2VsbCBhcyBpbiBJU0EgZGVwZW5kZW50IGNvZGUuIFRoZSBuZXcgSHlwZXItVg0KY2xvY2tz
b3VyY2UgZHJpdmVyIGlzIElTQSBpbmRlcGVuZGVudCwgd2l0aCBhIGp1c3QgZmV3IGRlcGVuZGVu
Y2llcyBvbg0KSVNBIHNwZWNpZmljIGZ1bmN0aW9ucy4gVGhlIHBhdGNoIHNlcmllcyBkb2VzIG5v
dCBjaGFuZ2UgYW55IGJlaGF2aW9yDQpvciBmdW5jdGlvbmFsaXR5IC0tIGl0IG9ubHkgcmVvcmdh
bml6ZXMgdGhlIGV4aXN0aW5nIGNvZGUgYW5kIGZpeGVzIHVwDQp0aGUgbGlua2FnZXMuIEEgZmV3
IHBsYWNlcyBvdXRzaWRlIG9mIEh5cGVyLVYgY29kZSBhcmUgZml4ZWQgdXAgdG8gdXNlDQp0aGUg
bmV3ICNpbmNsdWRlIGZpbGUgc3RydWN0dXJlLg0KDQpUaGlzIHJlc3RydWN0dXJpbmcgaXMgaW4g
cmVzcG9uc2UgdG8gTWFyYyBaeW5naWVyJ3MgcmV2aWV3IGNvbW1lbnRzDQpvbiBzdXBwb3J0aW5n
IEh5cGVyLVYgcnVubmluZyBvbiBBUk02NCwgYW5kIGlzIGEgZ29vZCBpZGVhIGluIGdlbmVyYWwu
DQpJdCBpbmNyZWFzZXMgdGhlIGFtb3VudCBvZiBjb2RlIHNoYXJlZCBiZXR3ZWVuIHRoZSB4ODYg
YW5kIEFSTTY0DQphcmNoaXRlY3R1cmVzLCBhbmQgcmVkdWNlcyB0aGUgc2l6ZSBvZiB0aGUgbmV3
IGNvZGUgZm9yIHN1cHBvcnRpbmcNCkh5cGVyLVYgb24gQVJNNjQuIEEgbmV3IHZlcnNpb24gb2Yg
dGhlIEh5cGVyLVYgb24gQVJNNjQgcGF0Y2hlcyB3aWxsDQpmb2xsb3cgb25jZSB0aGlzIGNsb2Nr
c291cmNlIHJlc3RydWN0dXJpbmcgaXMgYWNjZXB0ZWQuDQoNClRoZSBjb2RlIGlzIGRpZmYnZWQg
YWdhaW5zdCB0aGUgdXBzdHJlYW0gdGlwIHRyZWU6DQpnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgdGltZXJzL3Zkc28NCg0KQ2hhbmdlcyBp
biB2NDoNCiogUmV2aXNlZCBjb21taXQgbWVzc2FnZXMNCiogUmViYXNlZCB0byB1cHN0cmVhbSB0
aXAgdHJlZQ0KDQpDaGFuZ2VzIGluIHYzOg0KKiBSZW1vdmVkIGJvb2xlYW4gYXJndW1lbnQgdG8g
aHZfaW5pdF9jbG9ja3NvdXJjZSgpLiBBbHdheXMgY2FsbA0Kc2NoZWRfY2xvY2tfcmVnaXN0ZXIs
IHdoaWNoIGlzIG5lZWRlZCBvbiBBUk02NCBidXQgYSBuby1vcCBvbiB4ODYuDQoqIFJlbW92ZWQg
c2VwYXJhdGUgY3B1aHAgc2V0dXAgaW4gaHZfc3RpbWVyX2FsbG9jKCkgYW5kIGluc3RlYWQNCmRp
cmVjdGx5IGNhbGwgaHZfc3RpbWVyX2luaXQoKSBhbmQgaHZfc3RpbWVyX2NsZWFudXAoKSBmcm9t
DQpjb3JyZXNwb25kaW5nIFZNYnVzIGZ1bmN0aW9ucy4gIFRoaXMgbW9yZSBjbG9zZWx5IG1hdGNo
ZXMgb3JpZ2luYWwNCmNvZGUgYW5kIGF2b2lkcyBjbG9ja3NvdXJjZSBzdG9wL3Jlc3RhcnQgcHJv
YmxlbXMgb24gQVJNNjQgd2hlbg0KVk1idXMgY29kZSBkZW5pZXMgQ1BVIG9mZmxpbmluZyByZXF1
ZXN0Lg0KDQpDaGFuZ2VzIGluIHYyOg0KKiBSZXZpc2VkIGNvbW1pdCBzaG9ydCBkZXNjcmlwdGlv
bnMgc28gdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4NCnRoZSBmaXJzdCBhbmQgc2Vjb25kIHBhdGNo
ZXMgaXMgY2xlYXJlciBbR3JlZ0tIXQ0KKiBSZW5hbWVkIG5ldyBjbG9ja3NvdXJjZSBkcml2ZXIg
ZmlsZXMgYW5kIGZ1bmN0aW9ucyB0byB1c2UNCmV4aXN0aW5nICJ0aW1lciIgYW5kICJzdGltZXIi
IG5hbWVzIGluc3RlYWQgb2YgaW50cm9kdWNpbmcNCiJzeW50aW1lciIuIFtWaXRhbHkgS3V6bmV0
c292XQ0KKiBJbnRyb2R1Y2VkIENPTkZJR19IWVBFUl9USU1FUiB0byBmaXggYnVpbGQgcHJvYmxl
bSB3aGVuDQpDT05GSUdfSFlQRVJWPW0gW1ZpdGFseSBLdXpuZXRzb3ZdDQoqIEFkZGVkICJTdWdn
ZXN0ZWQtYnk6IE1hcmMgWnluZ2llciINCg0KTWljaGFlbCBLZWxsZXkgKDIpOg0KICBEcml2ZXJz
OiBodjogQ3JlYXRlIEh5cGVyLVYgY2xvY2tzb3VyY2UgZHJpdmVyIGZyb20gZXhpc3RpbmcNCiAg
ICBjbG9ja2V2ZW50cyBjb2RlDQogIERyaXZlcnM6IGh2OiBNb3ZlIEh5cGVyLVYgY2xvY2tzb3Vy
Y2UgY29kZSB0byBuZXcgY2xvY2tzb3VyY2UgZHJpdmVyDQoNCiBNQUlOVEFJTkVSUyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZtYS5j
ICAgICAgICAgICAgICAgIHwgICAyICstDQogYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyAgICAg
ICAgICAgICAgICB8ICA5MSArLS0tLS0tLS0NCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYt
dGxmcy5oICAgICAgIHwgICA2ICsNCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oICAg
ICAgICAgIHwgIDgxICsrLS0tLS0tDQogYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9nZXR0aW1l
b2ZkYXkuaCB8ICAgMiArLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYyAgICAgICAg
ICAgfCAgIDIgKw0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvTWFrZWZpbGUgICAgICAgICAgICAgfCAgIDEgKw0K
IGRyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMgICAgICAgfCAzMjEgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvaHYvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDMgKw0KIGRyaXZlcnMvaHYvaHYuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAxNTYgKy0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9odi9oeXBlcnZfdm1idXMuaCAgICAg
ICAgICAgICAgICB8ICAgMyAtDQogZHJpdmVycy9odi92bWJ1c19kcnYuYyAgICAgICAgICAgICAg
ICAgICB8ICA0MiArKy0tDQogaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaCAgICAg
ICB8IDEwNSArKysrKysrKysrDQogMTUgZmlsZXMgY2hhbmdlZCwgNDgzIGluc2VydGlvbnMoKyks
IDMzNSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbG9ja3NvdXJj
ZS9oeXBlcnZfdGltZXIuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2Nsb2Nrc291cmNl
L2h5cGVydl90aW1lci5oDQoNCi0tIA0KMS44LjMuMQ0KDQo=
