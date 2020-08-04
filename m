From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Tue, 4 Aug 2020 08:44:42 +0000
Message-ID: <9371b8272fd84280ae40b409b260bab3@AcuMS.aculab.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
         <20200730152250.GG23808@casper.infradead.org>
         <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
         <20200730171251.GI23808@casper.infradead.org>
         <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
         <20200730174956.GK23808@casper.infradead.org>
         <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
         <87y2n03brx.fsf@x220.int.ebiederm.org>
         <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
         <877dufvje9.fsf@x220.int.ebiederm.org>
 <1596469370.29091.13.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1596469370.29091.13.camel@HansenPartnership.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'James Bottomley' <James.Bottomley@HansenPartnership.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "keescook@chromium.org" <keescook@chromium.org>, "gerg@linux-m68k.org" <gerg@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

RnJvbTogSmFtZXMgQm90dG9tbGV5DQo+IFNlbnQ6IDAzIEF1Z3VzdCAyMDIwIDE2OjQzDQo+IA0K
PiBPbiBNb24sIDIwMjAtMDgtMDMgYXQgMTA6MjggLTA1MDAsIEVyaWMgVy4gQmllZGVybWFuIHdy
b3RlOg0KPiBbLi4uXQ0KPiA+IFdoYXQgaXMgd3Jvbmcgd2l0aCBsaXZlIG1pZ3JhdGlvbiBiZXR3
ZWVuIG9uZSBxZW11IHByb2Nlc3MgYW5kDQo+ID4gYW5vdGhlciBxZW11IHByb2Nlc3Mgb24gdGhl
IHNhbWUgbWFjaGluZSBub3Qgd29yayBmb3IgdGhpcyB1c2UgY2FzZT8NCj4gPg0KPiA+IEp1c3Qg
cmV1c2luZyBsaXZlIG1pZ3JhdGlvbiB3b3VsZCBzZWVtIHRvIGJlIHRoZSBzaW1wbGVzdCBwYXRo
IG9mDQo+ID4gYWxsLCBhcyB0aGUgY29kZSBpcyBhbHJlYWR5IGltcGxlbWVudGVkLiAgRnVydGhl
ciBpZiBzb21ldGhpbmcgZ29lcw0KPiA+IHdyb25nIHdpdGggdGhlIGxpdmUgbWlncmF0aW9uIHlv
dSBjYW4gZmFsbGJhY2sgdG8gdGhlIGV4aXN0aW5nDQo+ID4gcHJvY2Vzcy4gIFdpdGggZXhlYyB0
aGVyZSBpcyBubyBmYWxsYmFjayBpZiB0aGUgbmV3IHZlcnNpb24gZG9lcyBub3QNCj4gPiBwcm9w
ZXJseSBzdXBwb3J0IHRoZSBoYW5kb2ZmIHByb3RvY29sIG9mIHRoZSBvbGQgdmVyc2lvbi4NCj4g
DQo+IEFjdHVhbGx5LCBjb3VsZCBJIGFzayB0aGlzIGFub3RoZXIgd2F5OiB0aGUgb3RoZXIgcGF0
Y2ggc2V0IHlvdSBzZW50IHRvDQo+IHRoZSBLVk0gbGlzdCB3YXMgdG8gc25hcHNob3QgdGhlIFZN
IHRvIGEgUEtSQU0gY2Fwc3VsZSBwcmVzZXJ2ZWQgYWNyb3NzDQo+IGtleGVjIHVzaW5nIHplcm8g
Y29weSBmb3IgZXh0cmVtZWx5IGZhc3Qgc2F2ZS9yZXN0b3JlLiAgVGhlIG9yaWdpbmFsDQo+IGlk
ZWEgd2FzIHRvIHVzZSB0aGlzIGFzIHBhcnQgb2YgYSBDUklVIGJhc2VkIHNuYXBzaG90LCBrZXhl
YyB0byBuZXcNCj4gc3lzdGVtLCByZXN0b3JlLiAgSG93ZXZlciwgd2h5IGNhbid0IHlvdSBkbyBh
IGxvY2FsIHNuYXBzaG90LCByZXN0YXJ0DQo+IHFlbXUsIHJlc3RvcmUgdXNpbmcgdGhlIFBLUkFN
IGNhcHN1bGUgdG8gYWNoaWV2ZSBleGFjdGx5IHRoZSBzYW1lIGFzDQo+IE1BRFZfRE9FWEVDIGRv
ZXMgYnV0IHVzaW5nIGEgc3lzdGVtIHRoYXQncyBlYXN5IHRvIHJlYXNvbiBhYm91dD8gIEl0DQo+
IG1heSBiZSBzbGlnaHRseSBzbG93ZXIsIGJ1dCBJIHRoaW5rIHdlJ3JlIHN0aWxsIHRhbGtpbmcg
bWlsbGlzZWNvbmRzLg0KDQoNCkkndmUgaGFkIGFub3RoZXIgaWRlYSAodGhhdCBpcyBwcm9iYWJs
eSBpbXBvc3NpYmxlLi4uKS4NCldoYXQgYWJvdXQgYSAncmV2ZXJzZSBtbWFwJyBvcGVyYXRpb24u
DQpTb21ldGhpbmcgdGhhdCBjcmVhdGVzIGFuIGZkIHdob3NlIGNvbnRlbnRzIGFyZSBhIGNodW5r
IG9mIHRoZQ0KcHJvY2Vzc2VzIGFkZHJlc3Mgc3BhY2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=
