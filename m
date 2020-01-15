From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Date: Wed, 15 Jan 2020 23:01:48 +0000
Message-ID: <6eb7587b-c3bc-691d-9d27-d4e687114a42@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-2-vgupta@synopsys.com>
 <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <B676B95FC3FC714FA1FB6336730C5498@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

T24gMS8xNC8yMCAxMjo1NyBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MTQsIDIwMjAgYXQgOTowOCBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4+IFRoZXJlIGFyZSAyIGdlbmVyaWMgdmFyYWludHMgb2Ygc3RybmNweV9m
cm9tX3VzZXIoKSAvIHN0cm5sZW5fdXNlcigpDQo+PiAgKDEpLiBpbmxpbmUgdmVyc2lvbiBpbiBh
c20tZ2VuZXJpYy91YWNjZXNzLmgNCj4+ICAoMikuIG9wdGltaXplZCB3b3JkLWF0LWEtdGltZSB2
ZXJzaW9uIGluIGxpYi8qDQo+Pg0KPj4gVGhpcyBwYXRjaCBkaXNhYmxlcyAjMSBpZiAjMiBzZWxl
Y3RlZC4gVGhpcyBhbGxvd3MgYXJjaGVzIHRvIGNvbnRpbnVlDQo+PiByZXVzaW5nIGFzbS1nZW5l
cmljL3VhY2Nlc3MuaCBmb3IgcmVzdCBvZiBjb2RlDQo+Pg0KPj4gVGhpcyBjYW1lIHVwIHdoZW4g
c3dpdGNoaW5nIEFSQyB0byBnZW5lcmljIHdvcmQtYXQtYS10aW1lIGludGVyZmFjZQ0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4gVGhp
cyBsb29rcyBsaWtlIGEgdXNlZnVsIGNoYW5nZSwgYnV0IEkgdGhpbmsgd2UgY2FuIGRvIGV2ZW4g
YmV0dGVyOiBJdA0KPiBzZWVtcyB0aGF0DQo+IHRoZXJlIGFyZSBubyAgY2FsbGVycyBvZiBfX3N0
cm5sZW5fdXNlciBvciBfX3N0cm5jcHlfZnJvbV91c2VyICBpbiB0aGUNCj4ga2VybmVsIHRvZGF5
LCBzbyB0aGVzZSBzaG91bGQgbm90IGJlIGRlZmluZWQgZWl0aGVyIHdoZW4gdGhlIEtjb25maWcg
c3ltYm9scw0KPiBhcmUgc2V0LiBBbHNvLCBJIHdvdWxkIHN1Z2dlc3QgbW92aW5nIHRoZSAnZXh0
ZXJuJyBkZWNsYXJhdGlvbiBmb3IgdGhlIHR3bw0KPiBmdW5jdGlvbnMgaW50byB0aGUgI2Vsc2Ug
YnJhbmNoIG9mIHRoZSBjb25kaXRpb25hbCBzbyBpdCBkb2VzIG5vdCBuZWVkIHRvIGJlDQo+IGR1
cGxpY2F0ZWQuDQoNCkdpdmVuIHdoZXJlIHRoaW5ncyBzZWVtIHRvIGJlIGhlYWRpbmcsIGRvIHUg
c3RpbGwgd2FudCBhbiB1cGRhdGVkIHBhdGNoIGZvciB0aGlzDQpvciBkbyB1IHBsYW4gdG8gZGl0
Y2ggdGhlIGlubGluZSB2ZXJzaW9uIGluIHNob3J0IHRlcm0gYW55d2F5cy4NCg0KLVZpbmVldA0K
DQo=
