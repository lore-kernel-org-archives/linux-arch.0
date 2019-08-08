Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:63109
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730678AbfHHJ1p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 05:27:45 -0400
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Thu, 8 Aug 2019 09:25:47 +0000
Message-ID: <48c5f9b3-d253-bede-e755-0aabba2757b5@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
In-Reply-To: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <960F9790878B3346A988307D90E92E55@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: nd <nd@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Will Deacon <Will.Deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190808092547.Q0FXHhGkxwLAp1r2MWOLVxItVdl_yYkO5duo0v_vScM@z>

T24gMDcvMDgvMjAxOSAyMTozOCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+IE9uIDgvNy8xOSA4OjUz
IEFNLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6DQo+PiArLSBUaGUgc3lzY2FsbCBiZWhhdmlvdXIg
aXMgdW5kZWZpbmVkIGZvciBub24gdmFsaWQgdGFnZ2VkIHBvaW50ZXJzLg0KPiANCj4gRG8geW91
IHJlYWxseSBtZWFuICJ1bmRlZmluZWQiPyAgSSBtZWFuLCBhIGJhZCBwb2ludGVyIGlzIGEgYmFk
IHBvaW50ZXIuDQo+ICBXaHkgc2hvdWxkIGl0IG1hdHRlciBpZiBpdCdzIGEgdGFnZ2VkIGJhZCBw
b2ludGVyIG9yIGFuIHVudGFnZ2VkIGJhZA0KPiBwb2ludGVyPw0KDQpiYWQgcG9pbnRlcnMgYXJl
IGludmFsaWQsIGJ1dCBzb21lIG5vbi1iYWQgcG9pbnRlcnMgYXJlDQphbHNvIGludmFsaWQgaWYg
dGhleSBhcmUgdGFnZ2VkIChlLmcuIHRhZ2dlZCBwb2ludGVyIHRvDQpkZXZpY2UgbWVtb3J5Pykg
dGhvc2UgbWF5IGJlIHZhbGlkIHRvIGRlcmVmZXJlbmNlIGluDQp1c2Vyc3BhY2UgYnV0IGRvbid0
IHdvcmsgYWNyb3NzIHRoZSBzeXNjYWxsIGFiaSAoZGV2aWNlDQpkcml2ZXIgZG9lcyBub3QgaGFu
ZGxlIHRoZSB0YWc/KS4NCg0KPj4gKy0gbW1hcCgpIGFkZHIgcGFyYW1ldGVyLg0KPj4gKw0KPj4g
Ky0gbXJlbWFwKCkgbmV3X2FkZHJlc3MgcGFyYW1ldGVyLg0KPiANCj4gSXMgbXVubWFwKCkgbWlz
c2luZz8gIE9yIHdhcyB0aGVyZSBhIHJlYXNvbiBmb3IgbGVhdmluZyBpdCBvdXQ/DQoNCnRoZSBu
ZXcgYWRkcmVzcyBpbiBtbWFwIGFuZCBtcmVtYXAgbWF5IG5vdCBiZSBjdXJyZW50bHkNCm1hcHBl
ZCwgb3RoZXIgbSogZnVuY3Rpb25zIG9wZXJhdGUgb24gZXhpc3RpbmcgbWFwcGluZ3MNCihtdW5t
YXAsIG1hZHZpc2UsIG1wcm90ZWN0LCBtbG9jaywuLi4pDQoNCmFsdGhvdWdoIGJ5IHRoaXMgbG9n
aWMgYnJrIChhbmQgcmVsYXRlZCBQUl9TRVRfTU1fKikNCnNob3VsZCBiZSBleGNsdWRlZCBoZXJl
IHRvby4NCg0KPj4gKy0gcHJjdGwoUFJfU0VUX01NLCBgYCpgYCwgLi4uKSBvdGhlciB0aGFuIGFy
ZzIgUFJfU0VUX01NX01BUCBhbmQNCj4+ICsgIFBSX1NFVF9NTV9NQVBfU0laRS4NCj4+ICsNCj4+
ICstIHByY3RsKFBSX1NFVF9NTSwgUFJfU0VUX01NX01BUHssX1NJWkV9LCAuLi4pIHN0cnVjdCBw
cmN0bF9tbV9tYXAgZmllbGRzLg0KPj4gKw0KPj4gK0FueSBhdHRlbXB0IHRvIHVzZSBub24temVy
byB0YWdnZWQgcG9pbnRlcnMgd2lsbCBsZWFkIHRvIHVuZGVmaW5lZA0KPj4gK2JlaGF2aW91ci4N
Cj4gDQo+IEkgd29uZGVyIGlmIHlvdSB3YW50IHRvIGdlbmVyYWxpemUgdGhpcyBhIGJpdC4gIEkg
dGhpbmsgeW91J3JlIHNheWluZw0KPiB0aGF0IHBhcnRzIG9mIHRoZSBBQkkgdGhhdCBtb2RpZnkg
dGhlICpsYXlvdXQqIG9mIHRoZSBhZGRyZXNzIHNwYWNlDQo+IG5ldmVyIGFjY2VwdCB0YWdnZWQg
cG9pbnRlcnMuDQoNCnNvbWV0aGluZyBsaWtlIHRoYXQsIGJ1dCBpIHRoaW5rIHRoaXMgaXMgaGFy
ZCB0byBzcGVjaWZ5DQppbiBhIGdlbmVyaWMgd2F5Lg0K
