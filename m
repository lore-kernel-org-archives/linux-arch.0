From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
Date: Wed, 15 Jan 2020 23:00:17 +0000
Message-ID: <ff24ea2b-e232-36a2-4e11-c89400feff45@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-3-vgupta@synopsys.com>
 <CAAeHK+zxVw6jOu-NzjR14U_i5cpDynE=OC3D5WswTvqT8o5NhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+zxVw6jOu-NzjR14U_i5cpDynE=OC3D5WswTvqT8o5NhQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <3D60597E658C594BBC4C84C7030A0485@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Christian Brauner <christian.brauner@ubuntu.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

T24gMS8xNS8yMCA2OjQyIEFNLCBBbmRyZXkgS29ub3ZhbG92IHdyb3RlOg0KPj4gLSAgICAgICBt
YXhfYWRkciA9IHVzZXJfYWRkcl9tYXgoKTsNCj4+IC0gICAgICAgc3JjX2FkZHIgPSAodW5zaWdu
ZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHNyYyk7DQo+DQo+IElmIHlvdSBlbmQgdXAgY2hhbmdpbmcg
dGhpcyBjb2RlLCB5b3UgbmVlZCB0byBrZWVwIHRoZSB1bnRhZ2dlZF9hZGRyKCkNCj4gbG9naWMs
IG90aGVyd2lzZSB0aGlzIGJyZWFrcyBhcm02NCB0YWdnZWQgYWRkcmVzcyBBQkkgWzFdLg0KDQpJ
dCBpcyBtb290IHBvaW50IG5vdywgYnV0IGZ3aXcgdW50YWdnZWRfYWRkcigpIHdvdWxkIG5vdCBo
YXZlIGJlZW4gbmVlZGVkIGFueW1vcmUNCmFzIGl0IHdhcyBvbmx5IG5lZWRlZCB0byBjb21wdXRl
IHRoZSBwb2ludGVyIGRpZmZlcmVuY2Ugd2hpY2ggbXkgcGF0Y2ggZ290IHJpZCBvZi4NCg0KPiAN
Cj4gWzFdIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2FybTY0L3RhZ2dl
ZC1hZGRyZXNzLWFiaS5odG1sDQo+IA0KPj4gLSAgICAgICBpZiAobGlrZWx5KHNyY19hZGRyIDwg
bWF4X2FkZHIpKSB7DQo+PiAtICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBtYXggPSBtYXhf
YWRkciAtIHNyY19hZGRyOw0KPj4gKyAgICAgICBrYXNhbl9jaGVja193cml0ZShkc3QsIGNvdW50
KTsNCj4+ICsgICAgICAgY2hlY2tfb2JqZWN0X3NpemUoZHN0LCBjb3VudCwgZmFsc2UpOw0KPj4g
KyAgICAgICBpZiAodXNlcl9hY2Nlc3NfYmVnaW4oc3JjLCBjb3VudCkpIHsNCg0K
