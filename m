Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:13528 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeJLXpJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Oct 2018 19:45:09 -0400
From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v3 0/7] ia64: system call table generation support
Date: Fri, 12 Oct 2018 16:11:56 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D410C05@ORSMSX107.amr.corp.intel.com>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <3908561D78D1C84285E8C5FCA982C28F7D40F9DD@ORSMSX107.amr.corp.intel.com>
 <CALxhOngtGNP7MATzwtMZd_Xw+rqvdhP9NMtTxwCEgmzayZshOQ@mail.gmail.com>
In-Reply-To: <CALxhOngtGNP7MATzwtMZd_Xw+rqvdhP9NMtTxwCEgmzayZshOQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181012161156.dZXT2uVvuY0SD7qW6ZXPRj8b3l9pLxDskdIWbLAZKNo@z>

PiBJIHN1c3BlY3QgdGhlIG9mZnNldCBsb2dpYyBpbiB0aGUgc3lzdGVtIGNhbGwgZ2VuZXJhdGlv
biBzY3JpcHQgaGFkIGEgYnVnLiBUaGF0DQo+IEkgZml4ZWQgaXQgaW4gdGhpcyBwYXRjaCBzZXJp
ZXMuDQo+DQo+IEFybmQgYW5kIEV1Z2VuZSBoYWQgc2hhcmVkIGZldyBjb21tZW50cyBvbiBhZGRp
bmcgbmV3IHN5c3RlbSBjYWxsIGVudHJ5IGluIHRoZQ0KPiB0YWJsZSBhbmQgc29tZSBvdGhlciB0
aGluZ3MuIEFwcHJlY2lhdGUgaWYgeW91IGNhbiByZXZpZXcgdGhpcyBwYXRjaA0KPiBzZXJpZXMg
c28gSSBjYW4NCj4gZmluYWxpemUgc3lzdGVtIGNhbGwgdGFibGUgaW1wbGVtZW50YXRpb24gZm9y
IGlhNjQgYXJjaGl0ZWN0dXJlLg0KDQpUaGUgbmV0IGVmZmVjdCBvZiB0aGVzZSBpcyBqdXN0IHRv
IG1ha2UgaXQgZWFzaWVyIHRvIGFkZCBuZXcgc3lzdGVtIGNhbGxzLiBKdXN0DQplZGl0IHRoZSB0
YWJsZSwgaW5zdGVhZCBvZiBlZGl0aW5nIGVudHJ5LlMgYW5kIHVuaXN0ZC5oIHBpY2tpbmcgdGhl
IG5leHQgbnVtYmVyDQooYW5kIHJlbWVtYmVyaW5nIHRvIGluY3JlYXNlICB0aGUgTlJfc3lzY2Fs
bHMpLiBSaWdodD8NCg0KSSdtIGN1cnJlbnRseSBiYWZmbGVkIGF0IHdoaWNoIGxpbmtlciBtYWdp
YyBtYWtlcyB0aGUgdW5zdXBwb3J0ZWQgc3lzdGVtDQpjYWxscyBhbGlhcyB0byBzeXNfbmlfc3lz
Y2FsbC4NCg0KSSdtIGFsc28gdW5jZXJ0YWluIHdoZXRoZXIgYWxsb2NhdGluZyBzeXN0ZW0gY2Fs
bCBudW1iZXJzIGFuZCBjcmVhdGluZw0KZW50cnkgcG9pbnRzIGZvciBhbGwgdGhlIHVuc3VwcG9y
dGVkIHN5c2NhbGxzIGlzIHRoZSByaWdodCB0aGluZyB0byBkby4gTWlnaHQNCnRoYXQgcHV6emxl
IGFuZCBmcnVzdHJhdGUgZm9sa3Mgd2hvc2UgYXBwbGljYXRpb25zIGJ1aWxkLCBidXQgdGhlbiBm
YWlsIGF0DQpydW4tdGltZSB3aXRoIC1FTk9TWVMuDQoNCi1Ub255DQo=
