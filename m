From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 37/56] microblaze_v2: headers for irq
Date: Sun, 11 May 2008 15:56:08 +0200
Message-ID: <4826FAF8.20009@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <598221ce2159046614d7b158ea62d5af51907af3.1209897266.git.monstr@monstr.eu> <41c1f410eaafd875246362d10ef9866d8cc2a934.1209897266.git.monstr@monstr.eu> <09ce2baf0c8308d3fbca98e7eb36a6aab59112a7.1209897266.git.monstr@monstr.eu> <c9418c683be99ae12abb89575c362d586c026bad.1209897266.git.monstr@monstr.eu> <cfde3796e95bdd17c32e4fd7762d0aee55967707.1209897266.git.monstr@monstr.eu> <8aba2d82c85cd1d5b56de328c1fd080ee51f0211.1209897266.git.monstr@monstr.eu> <c4000ff625bd217f9bb683e3bf8c7193a82bd744.1209897266.git.monstr@monstr.eu> <491f823fac6c03cc36834ec569a45d30a03a72cf.1209897266.git.monstr@monstr.eu> <96f2004535c34a0c762bf2012c299cbf9f89ab32.1209897266.git.monstr@monstr.eu> <92cd3a27b393bb394d48902594152351a92c59bb.1209897266.git.mons
 tr@monstr.eu> <4e20213f5f296268a24955df8c951f7fba279816.1209897266.git.monstr@monstr.eu> <alpine.LFD.1.10.0805070925000.3318@apollo.tec.linutronix.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:57359 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752906AbYEKNzK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 11 May 2008 09:55:10 -0400
In-Reply-To: <alpine.LFD.1.10.0805070925000.3318@apollo.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: monstr@seznam.cz, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca

Hi Thomas,

> On Sun, 4 May 2008, monstr@seznam.cz wrote:
>> From: Michal Simek <monstr@monstr.eu>
>> +static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
>> +{
>> +	/* Nothing to do */
> 
> And used nowhere

I removed it.

>> +}
>> +
> 
> Thanks,
> 	tglx

Michal
