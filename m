Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j19A8sdt117404
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 10:08:54 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j19A8sn1124736
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 11:08:54 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j19A8rBW022213
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 11:08:54 +0100
In-Reply-To: <20050209094428.GB23943@wotan.suse.de>
Subject: Re: [PATCH] Fix compat shmget overflow
Message-ID: <OF57C10E69.8B803A13-ON41256FA3.00360882-41256FA3.0037BF5D@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 9 Feb 2005 11:08:54 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, corryk@us.ibm.com, linux-arch@vger.kernel.org, anton@samba.org, davem@davemloft.net
List-ID: <linux-arch.vger.kernel.org>

> This fixes an incorrect sign extension in the compat layer that
> breaks 32bit shmget that are >2GB. sys_shmget has a signed size_t size
> argument, and the int size argument comming from 32bit user space would
get
> sign extended to 64bit, which is wrong.

Ok for s390 though not needed. The address space for a 31 bit programs
is limited to 2GB anyway.

As you mention sys_shmget, I'm currently trying to find out why the
second argument of sys_ipc for ppc64, s390-64 and sparc64 has been
changed from "long" to "int". This limits the maximum size of a shared
memory segment to 2GB for the three archs. A cast to unsigned would
allow 4GB, still not enough for a 64 bit architecture in the long run.
Before I submit a patch to replace "int" with "long" again I'd like
to understand the reason for the change.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
