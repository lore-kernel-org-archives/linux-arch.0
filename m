Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:40570 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGIHWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 03:22:11 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 07:22:08 +0000
Message-ID: <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <20180709054842.GB7618@kroah.com>
         <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9F84045480B6D46A3A36428C8A395AC@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "geert@linux-m68k.org" <geert@linux-m68k.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180709072208.Z1O140BxW_x-eqlDPhRaNwDbbT6rSesl7xxGmYjHzcw@z>

SGkgR2VlcnQsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAwOTowNyArMDIwMCwgR2VlcnQgVXl0
dGVyaG9ldmVuIHdyb3RlOg0KPiBPbiBNb24sIEp1bCA5LCAyMDE4IGF0IDc6NDkgQU0gR3JlZyBL
SCA8Z3JlZ0Brcm9haC5jb20+IHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA3
OjQ0OjQ0QU0gKzAzMDAsIEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+ID4gRGVwZW5kaW5nIG9u
IEFCSSAibG9uZyBsb25nIiB0eXBlIG9mIGEgcGFydGljdWxhciAzMi1iaXQgQ1BVDQo+ID4gPiBt
aWdodCBiZSBhbGlnbmVkIGJ5IGVpdGhlciB3b3JkICgzMi1iaXRzKSBvciBkb3VibGUgd29yZCAo
NjQtYml0cykuDQo+IA0KPiBPciBldmVuIDE2LWJpdCAob24gZS5nLiBtNjhrKS4NCg0KSW5kZWVk
LCB0aGFua3MgZm9yIHRoZSBub3RlIQ0KV2lsbCBhZGQgdGhpcyBpbiBteSB2My4NCg0KRm9yIEFS
QyBJJ2QgbGlrZSB0aGlzIGZpeCB0byBiZSBiYWNrLXBvcnRlZCBzdGFydGluZw0KZnJvbSB2NC44
IHdoZXJlIHdlIGFkZGVkIHN1cHBvcnQgb2YgIm5hdGl2ZSIgYXRvbWljNjRfdCwgc2VlIGNvbW1p
dA0KY2U2MzY1MjcwZWNkICgiIEFSQ3YyOiBJbXBsZW1lbnQgYXRvbWljNjQgYmFzZWQgb24gTExP
Q0tEL1NDT05ERCBpbnN0cnVjdGlvbnMiKS4NCg0KV2hhdCBhYm91dCBtNjhrLCBkbyB5b3UgaGF2
ZSBhbnkgcHJlZmVyZW5jZSBvZiBlYXJsaWVzdCBrZXJuZWwgdmVyc2lvbg0Kd2hlcmUgdGhpcyBm
aXggbWlnaHQgYmUgdXNlZnVsPw0KDQotQWxleGV5
