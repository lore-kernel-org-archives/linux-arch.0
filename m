From: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH v3 2/3] arm64: Implement page table free interfaces
Date: Mon, 19 Mar 2018 19:29:27 +0000
Message-ID: <1521487759.2693.224.camel@hpe.com>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
         <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
Content-Language: en-US
Content-ID: <343C81ABBCE43E429C438C0119AB3BC0@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

T24gTW9uLCAyMDE4LTAzLTE5IGF0IDE4OjEwICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gSW1wbGVtZW50IHB1ZF9mcmVlX3BtZF9wYWdlKCkgYW5kIHBtZF9mcmVlX3B0ZV9wYWdlKCku
DQo+IA0KPiBJbXBsZW1lbnRhdGlvbiByZXF1aXJlcywNCj4gIDEpIEZyZWVpbmcgb2YgdGhlIHVu
LXVzZWQgbmV4dCBsZXZlbCBwYWdlIHRhYmxlcw0KPiAgMikgQ2xlYXJpbmcgb2ZmIHRoZSBjdXJy
ZW50IHB1ZC9wbWQgZW50cnkNCj4gIDMpIEludmFsaWRhdGUgVExCIHdoaWNoIGNvdWxkIGhhdmUg
cHJldmlvdXNseQ0KPiAgICAgdmFsaWQgYnV0IG5vdCBzdGFsZSBlbnRyeQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2hpbnRhbiBQYW5keWEgPGNwYW5keWFAY29kZWF1cm9yYS5vcmc+DQo+IC0tLQ0K
PiAgYXJjaC9hcm02NC9tbS9tbXUuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9tbXUuYyBiL2FyY2gvYXJtNjQvbW0vbW11
LmMNCj4gaW5kZXggZGE5ODgyOC4uYzcwZjEzOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9t
bS9tbXUuYw0KPiArKysgYi9hcmNoL2FybTY0L21tL21tdS5jDQo+IEBAIC00NSw2ICs0NSw3IEBA
DQo+ICAjaW5jbHVkZSA8YXNtL21lbWJsb2NrLmg+DQo+ICAjaW5jbHVkZSA8YXNtL21tdV9jb250
ZXh0Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL3B0ZHVtcC5oPg0KPiArI2luY2x1ZGUgPGFzbS90bGJm
bHVzaC5oPg0KPiAgDQo+ICAjZGVmaW5lIE5PX0JMT0NLX01BUFBJTkdTCUJJVCgwKQ0KPiAgI2Rl
ZmluZSBOT19DT05UX01BUFBJTkdTCUJJVCgxKQ0KPiBAQCAtOTc1LDEwICs5NzYsMzUgQEAgaW50
IHBtZF9jbGVhcl9odWdlKHBtZF90ICpwbWRwKQ0KPiAgDQo+ICBpbnQgcHVkX2ZyZWVfcG1kX3Bh
Z2UocHVkX3QgKnB1ZCwgdW5zaWduZWQgbG9uZyBhZGRyKQ0KPiAgew0KPiAtCXJldHVybiBwdWRf
bm9uZSgqcHVkKTsNCj4gKwlwbWRfdCAqcG1kOw0KPiArCWludCBpOw0KPiArDQo+ICsJcG1kID0g
X192YShwdWRfdmFsKCpwdWQpKTsNCj4gKwlpZiAocHVkX3ZhbCgqcHVkKSkgew0KPiArCQlmb3Ig
KGkgPSAwOyBpIDwgUFRSU19QRVJfUE1EOyBpKyspDQo+ICsJCQlwbWRfZnJlZV9wdGVfcGFnZSgm
cG1kW2ldLCBhZGRyICsgKGkgKiBQTURfU0laRSkpOw0KPiArDQo+ICsJCWZyZWVfcGFnZSgodW5z
aWduZWQgbG9uZykgcG1kKTsNCg0KV2h5IGRvIHlvdSB3YW50IHRvIGZyZWUgdGhpcyBwbWQgcGFn
ZSBiZWZvcmUgY2xlYXJpbmcgdGhlIHB1ZCBlbnRyeSBvbg0KdGhpcyBhcm02NCB2ZXJzaW9uIChh
cyBpdCBzZWVtcyB5b3UgaW50ZW50aW9uYWxseSBjaGFuZ2VkIGl0IGZyb20gdGhlDQp4ODYgdmVy
c2lvbik/ICBJdCBjYW4gYmUgcmV1c2VkIHdoaWxlIGJlaW5nIHBvaW50ZWQgYnkgdGhlIHB1ZC4g
IFNhbWUNCmZvciBwbWQuDQoNCj4gKwkJcHVkX2NsZWFyKHB1ZCk7DQo+ICsJCWZsdXNoX3RsYl9r
ZXJuZWxfcmFuZ2UoYWRkciwgYWRkciArIFBVRF9TSVpFKTsNCg0KU2luY2UgeW91IHB1cmdlIHRo
ZSBlbnRpcmUgcHVkIHJhbmdlIGhlcmUsIGRvIHlvdSBzdGlsbCBuZWVkIHRvIGNhbGwgDQpwbWRf
ZnJlZV9wdGVfcGFnZSgpIHRvIHB1cmdlIGVhY2ggcG1kIHJhbmdlPyAgVGhpcyBsb29rcyB2ZXJ5
IGV4cGVuc2l2ZS4NCllvdSBtYXkgd2FudCB0byBjb25zaWRlciBpZiBjYWxsaW5nIGludGVybmFs
IF9fcG1kX2ZyZWVfcHRlX3BhZ2UoKQ0Kd2l0aG91dCB0aGUgcHVyZ2Ugb3BlcmF0aW9uIHdvcmtz
Lg0KDQotVG9zaGk=
