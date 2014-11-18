Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:45932 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753160AbaKRJ54 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 Nov 2014 04:57:56 -0500
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 07074-05 for <linux-arch@vger.kernel.org>;
 Tue, 18 Nov 2014 09:57:47 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 0/4] Add lightweight memory barriers fast_rmb() and
 fast_wmb()
Date: Tue, 18 Nov 2014 09:57:14 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9F2930@AcuExch.aculab.com>
References: <20141117171005.22333.96544.stgit@ahduyck-server>
In-Reply-To: <20141117171005.22333.96544.stgit@ahduyck-server>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Alexander Duyck' <alexander.h.duyck@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "mathieu.desnoyers@polymtl.ca" <mathieu.desnoyers@polymtl.ca>, "peterz@infradead.org" <peterz@infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "mingo@kernel.org" <mingo@kernel.org>, "mikey@neuling.org" <mikey@neuling.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "donald.c.skidmore@intel.com" <donald.c.skidmore@intel.com>, "matthew.vick@intel.com" <matthew.vick@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>, "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "michael@ellerman.id.au" <michael@ellerman.id.au>, "tony.luck@intel.com" <tony.luck@intel.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "oleg@redhat.com" <oleg@redhat.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>
Message-ID: <20141118095714.i9jCG4dt4wf4cAcugSVApKuNapBmfdWFSqQCyGjVp5o@z>

RnJvbTogQWxleGFuZGVyIER1eWNrDQo+IFRoZXNlIHBhdGNoZXMgaW50cm9kdWNlIHR3byBuZXcg
cHJpbWl0aXZlcyBmb3Igc3luY2hyb25pemluZyBjYWNoZS1lbmFibGVkDQo+IG1lbW9yeSB3cml0
ZXMgYW5kIHJlYWRzLiAgVGhlc2UgdHdvIG5ldyBwcmltaXRpdmVzIGFyZToNCj4gDQo+IAlmYXN0
X3JtYigpDQo+IAlmYXN0X3dtYigpDQoNCk5vdCBzdXJlIEkgbGlrZSB0aGUgbmFtZXMuDQpJZiB0
aGUgYWltIGlzIHRvIHN5bmMgZGF0YSBpbnRvIHRoZSBsb2NhbCBjYWNoZSBzbyB0aGF0IGhhcmR3
YXJlDQp0aGF0IGlzIGRvaW5nIGNhY2hlLXNub29waW5nIGFjY2Vzc2VzIHNlZXMgdGhlIGRhdGEg
dGhlbiBtYXliZQ0KCWxvY2FsX3JtYigpIGFuZCBsb2NhbF93bWIoKQ0KDQpJSVJDIHJlYWRfYmFy
cmllcl9kZXBlbmRzKCkgaXMgYSBub3Agb24gZXZlcnl0aGluZyBleGNlcHQgYWxwaGEuDQpNYXli
ZSBhZGQgdGhlIGRlZmF1bHQgaWYgaXQgaXNuJ3QgZGVmaW5lZCBieSB0aGUgTUQgZmlsZT8NCg0K
CURhdmlkDQogDQo=
