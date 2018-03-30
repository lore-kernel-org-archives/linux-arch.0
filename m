Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:22514 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeC3Rmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Mar 2018 13:42:31 -0400
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 86C0B60526
        for <linux-arch@vger.kernel.org>; Fri, 30 Mar 2018 17:42:30 +0000 (UTC)
From: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [RFC PATCH] lib/ioremap: Avoid triggering BUG_ON when end is not
 PAGE_ALIGN
Date: Fri, 30 Mar 2018 17:41:50 +0000
Message-ID: <1522431689.2693.290.camel@hpe.com>
References: <1522385385-7074-1-git-send-email-xieyisheng1@huawei.com>
In-Reply-To: <1522385385-7074-1-git-send-email-xieyisheng1@huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <09CC2BC754EAF0498E344AEAAC336A7F@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "tanxiaojun@huawei.com" <tanxiaojun@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jcm@redhat.com" <jcm@redhat.com>
Message-ID: <20180330174150.g9qfD0XLUvznZyDxpe5tkslKNmgxnSgSxXwSO8QncAM@z>

T24gRnJpLCAyMDE4LTAzLTMwIGF0IDEyOjQ5ICswODAwLCBZaXNoZW5nIFhpZSB3cm90ZToNCj4g
WmhvdSByZXBvcnRlZCBhIGJ1ZyBvbiBIaXNpbGljb24gYXJtNjQgRDA2IHBsYXRmb3JtIHdpdGgg
NjRLQiBwYWdlIHNpemU6DQogOg0KPiBUaGUgY2F1c2UgaXMgdGhlIHNpemUgb2YgUENJIElPIHJl
c291cmNlIGlzIDMyS0IsIHdoaWNoIGlzIDRLIGFsaWduZWQgYnV0DQo+IG5vdCA2NEtCIGFsaWdu
ZWQsIHNvIHdoZW4gZG8gaW9yZW1hcF9wdGVfcmFuZ2UoKSwgaXRzIGluY29taW5nIGVuZCBpcyBu
b3QNCj4gUEFHRV9BTElHTiBvbiA2NEtCIHBhZ2Ugc2l6ZSBzeXN0ZW0sIGJ1dCBpb3JlbWFwX3B0
ZV9yYW5nZSBpbmNyZWFzZSB0aGUNCj4gYWRkciBieSBQQUdFX1NJWkUsIHdoaWNoIG1ha2VzIGFk
ZHIgIT0gZW5kIHVudGlsIHRyaWdnZXIgQlVHX09OLg0KPiANCj4gVGhpcyBwYXRjaCBpbnRyb2R1
Y2VzIHB0ZV9hZGRyX2VuZChhZGRyLCBlbmQpIHRvIHJlc29sdmUgdGhpcyBwcm9ibGVtLCBqdXN0
DQo+IGFzIHdoYXQgcG1kX2FkZHJfZW5kIGRvLiBXaGVuIGVuZCBpcyBub3QgUEFHRV9BTElHTiwg
aXQgd2lsbCByZXR1cm4gZW5kDQo+IGluc3RlYWQgb2YgYWRkciArIFBBR0VfU0laRSwgdGhlcmVm
b3JlIGlvcmVtYXBfcHRlX3JhbmdlKCkgY2FuIGJyZWFrIG91dA0KPiB3aGVuIHJlYWwgZW5kIGlz
IGNvbWluZy4NCg0KaW9yZW1hcF9wdGVfcmFuZ2UoKSBhc3N1bWVzIHRoYXQgYWRkciBhbmQgZW5k
IGFyZSBhbGlnbmVkIGJ5IFBBR0VfU0laRS4gDQpXaGlsZSBzb21lIGltcHJvdmVtZW50IGNhbiBi
ZSBtYWRlIGluIHRoZSByYW5nZSBjaGVjayBhbmQgZG9jdW1lbnRhdGlvbiwNCiBJIGRvIG5vdCB0
aGluayBpdCBpcyBzYWZlIGZvciBsZXR0aW5nIHRoaXMgbGlicmFyeSBmdW5jdGlvbiB0byBtYXAN
Cm91dHNpZGUgb2YgYSByZXF1ZXN0ZWQgcmFuZ2UgYmxpbmRseS4NCg0KQ2FuIHlvdSBjaGFuZ2Ug
dGhlIGNhbGxlciBvZiBpb3JlbWFwX3BhZ2VfcmFuZ2UoKSB0byBhbGlnbiB0aGUgcmVxdWVzdA0K
YnkgUEFHRV9TSVpFIHNvIHRoYXQgdGhlIGNhbGxlciBpcyBhd2FyZSBvZiB3aGF0IGl0J3MgYXNr
aW5nIGZvcj8gDQoNClRoYW5rcywNCi1Ub3NoaQ0K
