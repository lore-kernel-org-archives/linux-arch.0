Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35486 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbfEaJlV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 May 2019 05:41:21 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: single copy atomicity for double load/stores on 32-bit systems
Date: Fri, 31 May 2019 09:41:17 +0000
Message-ID: <895ec12746c246579aed5dd98ace6e38@AcuMS.aculab.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
In-Reply-To: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Vineet Gupta' <Vineet.Gupta1@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190531094117.FJcp9tGsSECbIhgBgLgpr2FW3kiTyzwR2BiyfCwLN14@z>

RnJvbTogVmluZWV0IEd1cHRhDQo+IFNlbnQ6IDMwIE1heSAyMDE5IDE5OjIzDQouLi4NCj4gV2hp
bGUgaXQgc2VlbXMgcmVhc29uYWJsZSBmb3JtIGhhcmR3YXJlIHBvdiB0byBub3QgaW1wbGVtZW50
IHN1Y2ggYXRvbWljaXR5IGJ5DQo+IGRlZmF1bHQgaXQgc2VlbXMgdGhlcmUncyBhbiBhZGRpdGlv
bmFsIGJ1cmRlbiBvbiBhcHBsaWNhdGlvbiB3cml0ZXJzLiBUaGV5IGNvdWxkDQo+IGJlIGhhcHBp
bHkgdXNpbmcgYSBsb2NrbGVzcyBhbGdvcml0aG0gd2l0aCBqdXN0IGEgc2hhcmVkIGZsYWcgYmV0
d2VlbiAyIHRocmVhZHMNCj4gdy9vIG5lZWQgZm9yIGFueSBleHBsaWNpdCBzeW5jaHJvbml6YXRp
b24uIEJ1dCB1cGdyYWRlIHRvIGEgbmV3IGNvbXBpbGVyIHdoaWNoDQo+IGFnZ3Jlc3NpdmVseSAi
cGFja3MiIHN0cnVjdCByZW5kZXJpbmcgbG9uZyBsb25nIDMyLWJpdCBhbGlnbmVkICh2cy4gNjQt
Yml0IGJlZm9yZSkNCj4gY2F1c2luZyB0aGUgY29kZSB0byBzdWRkZW5seSBzdG9wIHdvcmtpbmcu
IElzIHRoZSBvbnVzIG9uIHRoZW0gdG8gZGVjbGFyZSBzdWNoDQo+IG1lbW9yeSBhcyBjMTEgYXRv
bWljIG9yIHNvbWUgc3VjaC4NCg0KQSAnbmV3JyBjb21waWxlciBjYW4ndCBzdWRkZW5seSBjaGFu
Z2UgdGhlIGFsaWdubWVudCBydWxlcyBmb3Igc3RydWN0dXJlIGVsZW1lbnRzLg0KVGhlIGFsaWdu
bWVudCBydWxlcyB3aWxsIGJlIHBhcnQgb2YgdGhlIEFCSS4NCg0KTW9yZSBsaWtlbHkgaXMgdGhh
dCB0aGUgc3RydWN0dXJlIGl0c2VsZiBpcyB1bmV4cGVjdGVkbHkgYWxsb2NhdGVkIG9uDQphbiA4
bis0IGJvdW5kYXJ5IGR1ZSB0byBjb2RlIGNoYW5nZXMgZWxzZXdoZXJlLg0KDQpJdCBpcyBhbHNv
IHdvcnRoIG5vdGluZyB0aGF0IGZvciBjb21wbGV0ZSBwb3J0YWJpbGl0eSBvbmx5IHdyaXRlcyB0
bw0KJ2Z1bGwgd29yZHMnIGNhbiBiZSBhc3N1bWVkIGF0b21pYy4NClNvbWUgb2xkIEFscGhhJ3Mg
ZGlkIFJNVyBjeWNsZXMgZm9yIGJ5dGUgd3JpdGVzLg0KKEFsdGhvdWdoIEkgc3VzcGVjdCBMaW51
eCBkb2Vzbid0IHN1cHBvcnQgdGhvc2UgYW55IG1vcmUuKQ0KDQpFdmVuIHg4NiBjYW4gY2F0Y2gg
eW91IG91dC4NClRoZSBiaXQgb3BlcmF0aW9ucyB3aWxsIGRvIHdpZGVyIFJNVyBjeWNsZXMgdGhh
biB5b3UgZXhwZWN0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K
