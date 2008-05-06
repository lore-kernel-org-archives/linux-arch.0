From: Michal Simek <monstr@seznam.cz>
Subject: Re: LTP for no MMU systems
Date: Tue, 06 May 2008 17:26:00 +0200
Message-ID: <48207888.3070107@seznam.cz>
References: <48206ECF.9090005@seznam.cz> <8bd0f97a0805060749j28cb6fe6wfbdf0d3948d2f417@mail.gmail.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:60248 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758099AbYEFPYp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 11:24:45 -0400
In-Reply-To: <8bd0f97a0805060749j28cb6fe6wfbdf0d3948d2f417@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Hi Mike,

where is your repo with ltp and tests results?

Thanks,
Michal

>>  I tested Microblaze MMU kernel for finding where could be problem. I have no
>>  problem with compilation. Microblaze MMU test result is on
>>  http://www.monstr.eu/wiki/doku.php?id=kernel:testing.
>>
>>  I would like to test no MMU kernel too. Does anyone use it for no MMU kernel?
>>  (Blackfin, m68k and others)
> 
> yes, we run many of the tests under testcases/kernel/ on Blackfin
> -mike
> 
> 
