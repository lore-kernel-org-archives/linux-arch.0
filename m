From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5BPATCH=2026=2F60=5D=20microblaze=5Fv4=3A=20time=20support?=
Date: Fri, 27 Jun 2008 15:10:32 +0200 (CEST)
Message-ID: <4641.7464-1217-45420265-1214572232@seznam.cz>
References: <alpine.LFD.1.10.0806271240461.3297@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:46359 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbYF0NLZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 09:11:25 -0400
In-Reply-To: <alpine.LFD.1.10.0806271240461.3297@apollo.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?us-ascii?Q?Thomas=20Gleixner?= <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, =?us-ascii?Q?Michal=20Simek?= <monstr@monstr.eu>

>> +
>> +static inline void udelay(unsigned long usec)
>> +{
>> +}
>
>shouldnt this function be named zerodelay() ?
>
>Thanks,
>	tglx

I have prepared implementation of this function which sent me JW.
I did some changes which I test it because I found problem there. 

M
