Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1P9WrWM057066
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2005 09:32:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j1P9Wrrm177320
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2005 10:32:53 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j1P9WqfR022378
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2005 10:32:53 +0100
In-Reply-To: <20050223161138.00d8205f.davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in flush_hash_one_pte())
Message-ID: <OF8DC10747.D86A411A-ON41256FB3.00319563-41256FB3.003474CB@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 25 Feb 2005 10:32:57 +0100
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=CEBBE520DFA213F38f9e8a93df938690918cCEBBE520DFA213F3"
Content-Disposition: inline
To: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--0__=CEBBE520DFA213F38f9e8a93df938690918cCEBBE520DFA213F3
Content-type: text/plain; charset=US-ASCII

"David S. Miller" <davem@davemloft.net> wrote on 24.02.2005 01:11:38:

> I'm taking a slightly different approach this time around so things
> are easier to integrate.  Here is the first patch which builds the
> infrastructure.  Basically:
>
> 2) pte_clear() gets "mm" and "addr" arguments now.
>    This had a cascading effect on many ptep_test_and_*() routines.
> Specifically:
>    a) ptep_test_and_clear_{young,dirty}() now take "vma" and "address"
args.
>    b) ptep_get_and_clear now take "mm" and "address" args.
>    c) ptep_mkdirty was deleted, unused by any code.
>    d) ptep_set_wrprotect now takes "mm" and "address" args.

The change in the pte_clear prototype broke compilation on s390.
The attached little patch takes care of that. Runs fine now.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

(See attached file: set_pte_at_s390.diff)
--0__=CEBBE520DFA213F38f9e8a93df938690918cCEBBE520DFA213F3
Content-type: application/octet-stream;
	name="set_pte_at_s390.diff"
Content-Disposition: attachment; filename="set_pte_at_s390.diff"
Content-transfer-encoding: base64

ZGlmZiAtdXJOIGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1zMzkwL3BndGFibGUuaCBsaW51eC0yLjYt
cHRlL2luY2x1ZGUvYXNtLXMzOTAvcGd0YWJsZS5oCi0tLSBsaW51eC0yLjYvaW5jbHVkZS9hc20t
czM5MC9wZ3RhYmxlLmgJMjAwNS0wMi0yNSAxMDoxODowNS4wMDAwMDAwMDAgKzAxMDAKKysrIGxp
bnV4LTIuNi1wdGUvaW5jbHVkZS9hc20tczM5MC9wZ3RhYmxlLmgJMjAwNS0wMi0yNSAxMDoyMTo1
Ny4wMDAwMDAwMDAgKzAxMDAKQEAgLTU1MCw3ICs1NTAsNyBAQAogc3RhdGljIGlubGluZSBwdGVf
dCBwdGVwX2dldF9hbmRfY2xlYXIocHRlX3QgKnB0ZXApCiB7CiAJcHRlX3QgcHRlID0gKnB0ZXA7
Ci0JcHRlX2NsZWFyKG1tLCBhZGRyLCBwdGVwKTsKKwlwdGVfdmFsKCpwdGVwKSA9IF9QQUdFX0lO
VkFMSURfRU1QVFk7CiAJcmV0dXJuIHB0ZTsKIH0KIApAQCAtNTczLDcgKzU3Myw3IEBACiAJCQkJ
ICAgICAgOiAiPW0iICgqcHRlcCkgOiAibSIgKCpwdGVwKSwKIAkJCQkgICAgICAgICJhIiAocHRl
cCksICJhIiAoYWRkcmVzcykgKTsKICNlbmRpZiAvKiBfX3MzOTB4X18gKi8KLQlwdGVfY2xlYXIo
dm1hLT52bV9tbSwgYWRkcmVzcywgcHRlcCk7CisJcHRlX3ZhbCgqcHRlcCkgPSBfUEFHRV9JTlZB
TElEX0VNUFRZOwogCXJldHVybiBwdGU7CiB9CiAK

--0__=CEBBE520DFA213F38f9e8a93df938690918cCEBBE520DFA213F3--
