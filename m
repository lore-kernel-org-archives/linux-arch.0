Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:40463 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101AbYFZTBp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2008 15:01:45 -0400
Message-ID: <4863E370.9020205@seznam.cz>
Date: Thu, 26 Jun 2008 20:44:00 +0200
From: Michal Simek <monstr@seznam.cz>
Reply-To: monstr@seznam.cz
MIME-Version: 1.0
Subject: Re: [PATCH 46/60] microblaze_v4: termbits.h termios.h
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-32-git-send-email-monstr@seznam.cz>	<1214483429-32360-33-git-send-email-monstr@seznam.cz>	<1214483429-32360-34-git-send-email-monstr@seznam.cz>	<1214483429-32360-35-git-send-email-monstr@seznam.cz>	<1214483429-32360-36-git-send-email-monstr@seznam.cz>	<1214483429-32360-37-git-send-email-monstr@seznam.cz>	<1214483429-32360-38-git-send-email-monstr@seznam.cz>	<1214483429-32360-39-git-send-email-monstr@seznam.cz>	<1214483429-32360-40-git-send-email-monstr@seznam.cz>	<1214483429-32360-41-git-send-email-monstr@seznam.cz>	<1214483429-32360-42-git-send-email-monstr@seznam.cz>	<1214483429-32360-43-git-send-email-monstr@seznam.cz>	<1214483429-32360-44-git-send-email-monstr@seznam.cz>	<1214483429-32360-45-git-send-email-monstr@seznam.cz>	<1214483429-32360-46-git-send-email-monstr@seznam.cz>	<1214483429-32360-47-git-send-email-monstr@seznam.cz> <20080626141837.0f8f439d@lxorguk.ukuu.org.uk>
In-Reply-To: <20080626141837.0f8f439d@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, drepper@redhat.com, linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com, john.williams@petalogix.com
Message-ID: <20080626184400.ummnTUZuTKfbf9nz3SnmZbP2NMCNU8w4mNgYHSUgwIM@z>

OK.I'll fix it.

M

>> +++ b/include/asm-generic/termbits.h
>> @@ -0,0 +1,200 @@
> 
>> +/* c_cflag bit meaning */
>> +
>> +#define CBAUD	0010017
>> +#define B0	0000000 /* hang up */
> 
> You need BOTHER in here as well - especially if it is going to be generic.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

