From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v2 24/28] arm: Add support for generic vDSO
Date: Mon, 10 Dec 2018 14:13:43 -0800
Message-ID: <1f5de1a7-04f0-152f-03ad-e581b0ec1b17@android.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-25-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129170530.37789-25-vincenzo.frascino@arm.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

T24gMTEvMjkvMjAxOCAwOTowNSBBTSwgVmluY2Vuem8gRnJhc2Npbm8gd3JvdGU6Cj4gVGhlIGFy
bSB2RFNPIGxpYnJhcnkgcmVxdWlyZXMgc29tZSBhZGFwdGF0aW9ucyB0byB1c2UgdG8gdGFrZSBh
ZHZhbnRhZ2UKPiBvZiB0aGUgbmV3bHkgaW50cm9kdWNlZCBnZW5lcmljIHZEU08gbGlicmFyeS4K
VGVzdGVkLWJ5PyBXb3VsZCBsaWtlIHRvIG5vdGUgdGhhdCB0aGlzIHBhdGNoIHNlcmllcyB1cCB0
byAyNC8yOCB3YXMgCmJhY2stcG9ydGVkIHRvIGFuZHJvaWQtNC45IGFuZCB3b3JrZWQgc3VjY2Vz
c2Z1bGx5IG9uIGEgSGlrZXkgYXJtNjQgZGV2aWNlLgoKT25seSBzaWduaWZpY2FudCBjaGFuZ2Ug
d2FzIHRvIGFkZCBiYWNrIHN1cHBvcnQgZm9yIGNsYW5nIGluIAphcmNoL2FybTY0L01ha2VmaWxl
IChwc2V1ZG8gcGF0Y2gpOgoKIMKgaWZlcSAoJChDT05GSUdfR0VORVJJQ19DT01QQVRfVkRTTyks
IHkpCiDCoMKgIENST1NTX0NPTVBJTEVfQVJNMzIgPz0gJChDT05GSUdfQ1JPU1NfQ09NUElMRV9D
T01QQVRfVkRTTzoiJSI9JSkKCiDCoMKgIGlmZXEgKCQoQ1JPU1NfQ09NUElMRV9BUk0zMiksKQog
wqDCoCDCoCAkKGVycm9yIENST1NTX0NPTVBJTEVfQVJNMzIgbm90IGRlZmluZWQgb3IgZW1wdHks
IHRoZSBjb21wYXQgdkRTTyAKd2lsbCBub3QgYmUgYnVpbHQpCivCoMKgIGVsc2UgaWZlcSAoJChj
Yy1uYW1lKSxjbGFuZykKK8KgwqAgwqAgZXhwb3J0IENMQU5HX1RSSVBMRV9BUk0zMiA/PSAkKENS
T1NTX0NPTVBJTEVfQVJNMzIpCivCoMKgwqDCoCBleHBvcnQgQ0xBTkdfVEFSR0VUX0FSTTMyIDo9
IC0tdGFyZ2V0PSQobm90ZGlyIAokKENMQU5HX1RSSVBMRV9BUk0zMjolLT0lKSkKK8KgwqDCoMKg
IGV4cG9ydCBDT05GSUdfQ09NUEFUX1ZEU08gOj0geQorwqDCoMKgwqAgY29tcGF0X3Zkc28gOj0g
LURDT05GSUdfQ09NUEFUX1ZEU089MQotKyDCoCBlbHNlIGlmZXEgKCQoc2hlbGwgd2hpY2ggJChD
Uk9TU19DT01QSUxFX0FSTTMyKSQoY2MtbmFtZSkgMj4gCi9kZXYvbnVsbCksKQotKyDCoCDCoCAk
KGVycm9yICQoQ1JPU1NfQ09NUElMRV9BUk0zMikkKGNjLW5hbWUpIG5vdCBmb3VuZCwgY2hlY2sg
CkNST1NTX0NPTVBJTEVfQVJNMzIpCiDCoMKgIGVsc2UKIMKgwqAgwqAgZXhwb3J0IENST1NTX0NP
TVBJTEVfQVJNMzIKIMKgwqDCoMKgIGV4cG9ydCBDT05GSUdfQ09NUEFUX1ZEU08gOj0geQogwqDC
oMKgwqAgY29tcGF0X3Zkc28gOj0gLURDT05GSUdfQ09NUEFUX1ZEU089MQogwqDCoCBlbmRpZgog
wqBlbmRpZgoKLS0gTWFyawoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
