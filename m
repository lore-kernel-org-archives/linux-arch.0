Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266001AbUHQM1D@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:3773 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S265981AbUHQM1D
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Aug 2004 08:27:03 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id i7HCR2gB156962
	for <linux-arch@vger.kernel.org>; Tue, 17 Aug 2004 12:27:02 GMT
Received: from d12ml062.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i7HCR139061096
	for <linux-arch@vger.kernel.org>; Tue, 17 Aug 2004 14:27:01 +0200
Subject: Fw: [RFC] cputime patches.
Message-ID: <OF5188AD9E.C9DAEB9C-ON42256EF3.0043FFB3-42256EF3.00447109@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 17 Aug 2004 14:27:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





> With all these patches we finally have decent (that means usable) cpu
> accounting numbers on s390 and a fairer scheduling.
>
> The patches are against 2.6.8-rc4. I'll keep the fingers crossed
> that I didn't break any architecture.
>
> Now what do you guys think about it?

Is nobody interested in the cputime stuff or has nobody anything to
complain about it? In the later case I would forward the patches to
Andrew for -mm.

blue skies,
   Martin
