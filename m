Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53637 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeDIKwN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Apr 2018 06:52:13 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: dma-mapping: clear harmful GFP_* flags in common code
Date: Mon, 9 Apr 2018 10:52:09 +0000
Message-ID: <1523271128.5268.32.camel@synopsys.com>
References: <20180328133535.17302-1-hch@lst.de>
         <20180328133535.17302-2-hch@lst.de> <1522249966.2593.14.camel@synopsys.com>
In-Reply-To: <1522249966.2593.14.camel@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DA6D091281BFA4CA84A943AADC1B9D8@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "hch@lst.de" <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "sebott@linux.vnet.ibm.com" <sebott@linux.vnet.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180409105209.jhj4ctHizG3VueDnQks4GEpL9UhYCBq1-LTGBfIPIqs@z>

SGVsbG8sDQoNCk1heSB3ZSBoYXZlDQplODlmNWIzNzAxNTMgKCJkbWEtbWFwcGluZzogRG9uJ3Qg
Y2xlYXIgR0ZQX1pFUk8gaW4gZG1hX2FsbG9jX2F0dHJzIikNCmJhY2stcG9ydGVkIHRvIDQuMTYg
a2VybmVsIGFzIGl0IGZpeGVzOg0KDQo1N2JmNWE4ICgiZG1hLW1hcHBpbmc6IGNsZWFyIGhhcm1m
dWwgR0ZQXyogZmxhZ3MgaW4gY29tbW9uIGNvZGUiKS4NCg0KRm9yIG1vcmUgaW5mbyBhYm91dCBp
bnRyb2R1Y2VkIHByb2JsZW0gc2VlIHRoaXMgdGhyZWFkOg0KaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXNucHMtYXJjLzIwMTgtTWFyY2gvMDAzNjUyLmh0bWwNCg0K
LUFsZXhleQ==
