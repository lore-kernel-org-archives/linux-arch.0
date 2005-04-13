Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id j3D6GK5a153326
	for <linux-arch@vger.kernel.org>; Wed, 13 Apr 2005 06:16:20 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j3D6GK71123468
	for <linux-arch@vger.kernel.org>; Wed, 13 Apr 2005 08:16:20 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j3D6GJxK002857
	for <linux-arch@vger.kernel.org>; Wed, 13 Apr 2005 08:16:20 +0200
In-Reply-To: <20050412010132.5610d973.akpm@osdl.org>
MIME-Version: 1.0
Subject: Re: i386-cpu-hotplug-updated-for-mm.patch
Message-ID: <OF398D4BA7.7C664A64-ONC1256FE2.0022435F-C1256FE2.002264CD@de.ibm.com>
From: Heiko Carstens <Heiko.Carstens@de.ibm.com>
Date: Wed, 13 Apr 2005 08:16:15 +0200
Content-Type: text/plain; charset="US-ASCII"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Zwane Mwaikambo <zwane@holomorphy.com>
List-ID: <linux-arch.vger.kernel.org>

> This is the i386 cpu hotplug patch.  It's been in -mm for eons.
> 
> I was planning on merging it post-2.6.12 because several 
power-management
> related projects will use infrastructure which it provides.
> 
> It diddles with ia64, s390 and x86_64 a bit, so, please review...

The s390 changes are ok :)

Heiko
