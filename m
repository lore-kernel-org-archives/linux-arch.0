Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:29110 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265202AbUE0Ucc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 May 2004 16:32:32 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i4RKWWi5025142
	for <linux-arch@vger.kernel.org>; Thu, 27 May 2004 16:32:32 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i4RKWW015625
	for <linux-arch@vger.kernel.org>; Thu, 27 May 2004 16:32:32 -0400
Received: from cheetah.davemloft.net (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.10/8.12.10) with SMTP id i4RKWRhk010393
	for <linux-arch@vger.kernel.org>; Thu, 27 May 2004 16:32:27 -0400
Date: Thu, 27 May 2004 13:32:30 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Fw: Returned mail: see transcript for details
Message-Id: <20040527133230.2c96ca16.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__27_May_2004_13_32_30_-0700_njYQImGGURhWNAOh"
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Thu__27_May_2004_13_32_30_-0700_njYQImGGURhWNAOh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Sorry I'm retarted and mis-typed the list address.

Begin forwarded message:

Date: Thu, 27 May 2004 16:29:57 -0400
From: Mail Delivery Subsystem <MAILER-DAEMON@redhat.com>
To: <davem@redhat.com>
Subject: Returned mail: see transcript for details


The original message was received at Thu, 27 May 2004 16:29:54 -0400
from int-mx1.corp.redhat.com [172.16.52.254]

   ----- The following addresses had permanent fatal errors -----
<linux-arch@osdl.org>
    (reason: 550 5.1.1 <linux-arch@osdl.org>... User unknown)

   ----- Transcript of session follows -----
... while talking to smtp.osdl.org.:
>>> DATA
<<< 550 5.1.1 <linux-arch@osdl.org>... User unknown
550 5.1.1 <linux-arch@osdl.org>... User unknown


--Multipart=_Thu__27_May_2004_13_32_30_-0700_njYQImGGURhWNAOh
Content-Type: message/delivery-status;
 name="00000000.mimetmp"
Content-Disposition: attachment;
 filename="00000000.mimetmp"
Content-Transfer-Encoding: base64


UmVwb3J0aW5nLU1UQTogZG5zOyBteDEucmVkaGF0LmNvbQpSZWNlaXZlZC1Gcm9tLU1UQTogRE5T
OyBpbnQtbXgxLmNvcnAucmVkaGF0LmNvbQpBcnJpdmFsLURhdGU6IFRodSwgMjcgTWF5IDIwMDQg
MTY6Mjk6NTQgLTA0MDAKCkZpbmFsLVJlY2lwaWVudDogUkZDODIyOyBsaW51eC1hcmNoQG9zZGwu
b3JnCkFjdGlvbjogZmFpbGVkClN0YXR1czogNS4xLjEKUmVtb3RlLU1UQTogRE5TOyBzbXRwLm9z
ZGwub3JnCkRpYWdub3N0aWMtQ29kZTogU01UUDsgNTUwIDUuMS4xIDxsaW51eC1hcmNoQG9zZGwu
b3JnPi4uLiBVc2VyIHVua25vd24KTGFzdC1BdHRlbXB0LURhdGU6IFRodSwgMjcgTWF5IDIwMDQg
MTY6Mjk6NTYgLTA0MDAKCg==
--Multipart=_Thu__27_May_2004_13_32_30_-0700_njYQImGGURhWNAOh
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Return-Path: <davem@redhat.com>
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i4RKTsi5024386;
	Thu, 27 May 2004 16:29:54 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i4RKTq014776;
	Thu, 27 May 2004 16:29:52 -0400
Received: from cheetah.davemloft.net (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.10/8.12.10) with SMTP id i4RKTlhk009447;
	Thu, 27 May 2004 16:29:47 -0400
Date: Thu, 27 May 2004 13:29:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: torvalds@osdl.org
Cc: linux-arch@osdl.org, jparadis@redhat.com
Subject: ffs() inconsistency
Message-Id: <20040527132950.3ce28f41.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


It seems that x86 and currently x86_64 both return -1 from
ffs() if the word passed in is zero.

In contrast, linux/bitops.h:generic_ffs() returns 0 in this case.
Both sparc ports both return 0 as well.

Aparently XFS depends upon the "-1" return value behavior.
We need to clear things up.

The ffs man page, refernced above all of these implementations
as the specification, says that "0" should be returned.


--Multipart=_Thu__27_May_2004_13_32_30_-0700_njYQImGGURhWNAOh--
