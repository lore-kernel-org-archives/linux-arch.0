Return-Path: <arun.sharma@intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:15854 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262380AbUGZTvt
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Jul 2004 15:51:49 -0400
Message-ID: <410560C1.1060804@intel.com>
Date: Mon, 26 Jul 2004 12:51:29 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: compat_clock_getres shouldn't return -EFAULT if res == NULL
Content-Type: multipart/mixed;
 boundary="------------050508080507040801040403"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050508080507040801040403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Description within the patch.

	-Arun



--------------050508080507040801040403
Content-Type: text/plain;
 name="compat-clock-res.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="compat-clock-res.patch"

Rm9yIGNsb2NrX2dldHJlcyhjbG9ja2lkX3QgY2xvY2tfaWQsIHN0cnVjdCB0aW1lc3BlYyAq
cmVzKSwgdGhlCnNwZWNpZmljYXRpb24gc2F5cyAiSWYgcmVzIGlzIE5VTEwsIHRoZSBjbG9j
ayByZXNvbHV0aW9uIGlzIG5vdApyZXR1cm5lZC4iIFNvIHRoaXMga2luZCBvZiBjYWxsIHNo
b3VsZCBzdWNjZWVkLiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbgpyZXR1cm5zIC1FRkFV
TFQuCgpUaGUgcGF0Y2ggZml4ZXMgdGhlIGJ1ZyBpbiBjb21wYXRfY2xvY2tfZ2V0cmVzKCku
CgpTaWduZWQtb2ZmLWJ5OiBHb3Jkb24gSmluIDxnb3Jkb24uamluQGludGVsLmNvbT4KU2ln
bmVkLW9mZi1ieTogQXJ1biBTaGFybWEgPGFydW4uc2hhcm1hQGludGVsLmNvbT4KCi0tLSBs
aW51eC0yLjYuNy9rZXJuZWwvY29tcGF0LmMub3JpZwkyMDA0LTA3LTI1IDA5OjAyOjAxLjAw
MDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42Ljcva2VybmVsL2NvbXBhdC5jCTIwMDQtMDct
MjUgMDk6MDQ6NTEuMDAwMDAwMDAwIC0wNzAwCkBAIC01MzEsNyArNTMxLDcgQEAKIAllcnIg
PSBzeXNfY2xvY2tfZ2V0cmVzKHdoaWNoX2Nsb2NrLAogCQkJICAgICAgIChzdHJ1Y3QgdGlt
ZXNwZWMgX191c2VyICopICZ0cyk7CiAJc2V0X2ZzKG9sZGZzKTsKLQlpZiAoIWVyciAmJiBw
dXRfY29tcGF0X3RpbWVzcGVjKCZ0cywgdHApKQorCWlmICghZXJyICYmIHRwICYmIHB1dF9j
b21wYXRfdGltZXNwZWMoJnRzLCB0cCkpCiAJCXJldHVybiAtRUZBVUxUOyAKIAlyZXR1cm4g
ZXJyOwogfSAK
--------------050508080507040801040403--
