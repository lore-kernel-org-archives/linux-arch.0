Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.uu.se ([130.238.7.54]:60991 "EHLO smtp1.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039Ab3E2JHr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 May 2013 05:07:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <20901.49731.549060.203528@pilspetsen.it.uu.se>
Date: Wed, 29 May 2013 10:54:27 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
Subject: RE: A bug about system call on ARM
In-Reply-To: <35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1610991B85B@CNBJMBX05.corpusers.net>
	<CAFLxGvy39xWdZmtiVHP+y=zH1coCVmMuREcmD25wSb=w-VK7Xg@mail.gmail.com>
	<35FD53F367049845BC99AC72306C23D1610991B85D@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-ID: <20130529085427.hkrAu4-oEyACQH6LqBRaX60192DkEtcB2kpUXB3OnwA@z>

Wang, Yalin writes:
 > Hi  
 > 
 > I have download the latest linux kernel code  3.9.4
 > And Compare with  3.4.0 kernel .
 > 
 > It seems there is no change for this part ,
 > So it will still happen .
 > Does anyone know who is responsible for  arm arch part kernel code ?

A quick look in MAINTAINNERS would have told you:

ARM PORT
...
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

Please direct ARM-specific questions to that list.
