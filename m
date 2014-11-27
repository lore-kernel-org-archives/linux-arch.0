Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:43328 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751570AbaK0Pio (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Nov 2014 10:38:44 -0500
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 04659-04 for <linux-arch@vger.kernel.org>;
 Thu, 27 Nov 2014 15:38:34 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Thu, 27 Nov 2014 15:37:28 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9FDD6A@AcuExch.aculab.com>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com> <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530> <20141127120441.GB4390@osiris>
 <alpine.DEB.2.11.1411271602320.3961@nanos>
 <20141127161905.7c6220ee@thinkpad-w530>
In-Reply-To: <20141127161905.7c6220ee@thinkpad-w530>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'David Hildenbrand' <dahi@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "mingo@kernel.org" <mingo@kernel.org>
Message-ID: <20141127153728.oIwK_AoxSvHqxjOfKG-dhH8pblhXXtYgW7hC-FhmR7o@z>

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQNCi4uLg0KPiBBbHRob3VnaCBpdCBtaWdodCBub3QgYmUg
b3B0aW1hbCwgYnV0IGtlZXBpbmcgYSBzZXBhcmF0ZSBjb3VudGVyIGZvcg0KPiBwYWdlZmF1bHRf
ZGlzYWJsZSgpIGFzIHBhcnQgb2YgdGhlIHByZWVtcHRpb24gY291bnRlciBzZWVtcyB0byBiZSB0
aGUgb25seQ0KPiBkb2FibGUgdGhpbmcgcmlnaHQgbm93LiBJIGFtIG5vdCBzdXJlIGlmIGEgY29t
cGxldGVseSBzZXBhcmF0ZWQgY291bnRlciBpcyBldmVuDQo+IHBvc3NpYmxlLCBpbmNyZWFzaW5n
IHRoZSBzaXplIG9mIHRocmVhZF9pbmZvLg0KDQpXaGF0IGFib3V0IGFkZGluZyAoc2F5KSAweDEw
MDAwIGZvciB0aGUgbW9yZSByZXN0cmljdGl2ZSB0ZXN0Pw0KDQoJRGF2aWQNCg0K
