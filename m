Return-Path: <SRS0=vo9y=3E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbgAOXAX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 18:00:23 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
Date: Wed, 15 Jan 2020 23:00:17 +0000
Message-ID: <ff24ea2b-e232-36a2-4e11-c89400feff45@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-3-vgupta@synopsys.com>
 <CAAeHK+zxVw6jOu-NzjR14U_i5cpDynE=OC3D5WswTvqT8o5NhQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zxVw6jOu-NzjR14U_i5cpDynE=OC3D5WswTvqT8o5NhQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D60597E658C594BBC4C84C7030A0485@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Christian Brauner <christian.brauner@ubuntu.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20200115230017.F6lA1yfc67oIJ1oq3W2xcnmWM1X16ouUGrjkEtZ5ORc@z>

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
