Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:60965 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbYFZTTN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2008 15:19:13 -0400
Message-ID: <4863EBD9.1010601@seznam.cz>
Date: Thu, 26 Jun 2008 21:19:53 +0200
From: Michal Simek <monstr@seznam.cz>
Reply-To: monstr@seznam.cz
MIME-Version: 1.0
Subject: Re: [PATCH 08/60] microblaze_v4: exception handling
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	 <1214483429-32360-2-git-send-email-monstr@seznam.cz>	 <1214483429-32360-3-git-send-email-monstr@seznam.cz>	 <1214483429-32360-4-git-send-email-monstr@seznam.cz>	 <1214483429-32360-5-git-send-email-monstr@seznam.cz>	 <1214483429-32360-6-git-send-email-monstr@seznam.cz>	 <1214483429-32360-7-git-send-email-monstr@seznam.cz>	 <1214483429-32360-8-git-send-email-monstr@seznam.cz>	 <1214483429-32360-9-git-send-email-monstr@seznam.cz> <2c0942db0806260935p51564a7et6517b39e9a6706dc@mail.gmail.com>
In-Reply-To: <2c0942db0806260935p51564a7et6517b39e9a6706dc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>
Message-ID: <20080626191953.RDAU_WLbtP7gMTZIlNhWgxpImFj0fMb7xyap6B4D4cU@z>




> On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
>> +ex_sw:
>> +       /* Get the destination register number into r5 */
>> +       lbui    r5, r0, ex_reg_op;
>> +       /* Form store_word jump table offset (sw_table + (8 * regnum)) */
>> +       la      r6, r0, sw_table;
>> +       add     r5, r5, r5;
>> +       add     r5, r5, r5;
>> +       add     r5, r5, r5;
>> +       add     r5, r5, r6;
>> +       bra     r5;
> 
> Possibly stupid question: This is part of the unaligned store word
> exception handler, yes? Shouldn't the above add's be addk's to
> preserve the state of the carry register pre/post store?

I don't think that addk is important. I have some tests for exception, I want to
cover full exception handling.

M

