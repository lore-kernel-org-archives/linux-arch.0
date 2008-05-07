From: Michal Simek <monstr@seznam.cz>
Subject: Re: [microblaze-uclinux] [PATCH 04/56] microblaze_v2: Open firmware
 files
Date: Wed, 07 May 2008 21:12:10 +0200
Message-ID: <4821FF0A.7090508@seznam.cz>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>	 <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>	 <20080507160432.93FC11750046@mail35-dub.bigfish.com>	 <4821F794.10003@seznam.cz> <fa686aa40805071159ta7076c3va07e63ffd582ada4@mail.gmail.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:55663 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759313AbYEGTLe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 May 2008 15:11:34 -0400
In-Reply-To: <fa686aa40805071159ta7076c3va07e63ffd582ada4@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: monstr@seznam.cz, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>, David Miller <davem@davemloft.net>

Hi Grant,

you understand I use of_device, of_platform and prom_parse. If you do diff
between them they will almost the same. One small difference is in prom.c file.

I hope we will move these files to drivers/of.
This is not only question to me.

Paul, Steve and David: Can I moved these three files to drivers/of?

Michal

>> Hi Steve,
>>
>>  you are right. Microblaze don't need CONFIG_PPC_something but
>>  I keep this in files because it will be easier to move this to better place.
>>  I wanted to sort what Microblaze don't use.
>>
>>  I need to talk with people from sparc and powerpc what we can move and where.
>>  I see the best way to push these files to microblaze/kernel/ and then sychronize
>>  them with one patch - all archs together.
> 
> I would disagree.  I think its better to push (and get merged) patches
> to move the files first; then add microblaze on top of that.  You can
> start getting stuff merged piecemeal that way instead of relying on
> getting your entire patch series merged at once.
> 
> However, that's just my opinion, others may look at it differently.
> 
> Cheers,
> g.
> 
