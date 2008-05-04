From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 49/56] microblaze_v2: fcntl.h sockios.h ucontext.h
Date: Mon, 5 May 2008 00:43:41 +0200
Message-ID: <200805050043.43125.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <643084ee3819dd169cad3c4e3565c5ff20dd3429.1209897267.git.monstr@monstr.eu> <231ae415bf52de25c69f727fd13c50d201f8ecd8.1209897267.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:57894 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbYEDWns (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 18:43:48 -0400
In-Reply-To: <231ae415bf52de25c69f727fd13c50d201f8ecd8.1209897267.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
>  include/asm-microblaze/fcntl.h    |  104 +++++++++++++++++++++++++++++++++++++

Use the existing asm-generic version for this.

>  include/asm-microblaze/sockios.h  |   25 +++++++++
>  include/asm-microblaze/ucontext.h |   24 +++++++++

turn these into asm-generic versions.

	Arnd <><
