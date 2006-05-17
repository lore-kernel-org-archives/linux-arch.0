Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63637 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751226AbWEQLW1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 07:22:27 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.6/8.13.6) with ESMTP id k4HBMP5a150074
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 11:22:25 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4HBNseV117454
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 13:23:54 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id k4HBMOuF028686
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 13:22:25 +0200
Subject: Re: [patch] s390 kconfig cleanup.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.62.0605171314440.30686@pademelon.sonytel.be>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
	 <20060515212431.GA25010@moss.sous-sol.org>
	 <1147766908.5289.4.camel@localhost>
	 <20060516211216.GE23243@moss.sous-sol.org>
	 <1147853851.6661.2.camel@localhost>
	 <Pine.LNX.4.62.0605171314440.30686@pademelon.sonytel.be>
Content-Type: text/plain
Date: Wed, 17 May 2006 13:22:26 +0200
Message-Id: <1147864946.5540.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-05-17 at 13:18 +0200, Geert Uytterhoeven wrote:
> Which driver do you use for /dev/rtc? I couldn't find it at first sight.

s390 does not have /dev/rtc.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


