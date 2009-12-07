Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64976 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935279AbZLGPPI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2009 10:15:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: What's in asm-generic.git
Date: Mon, 7 Dec 2009 16:14:45 +0100
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com>
In-Reply-To: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 8bit
Message-ID: <200912071614.46166.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>
Message-ID: <20091207151445.-SkMliVRPh5no1wS1z3GSv0GYaZicDqM1g-P-P1ekRY@z>

On Monday 07 December 2009, liqin.chen@sunplusct.com wrote:
> Arnd Bergmann <arnd@arndb.de> Ð´ÓÚ 2009-12-04 03:14:08:
> 
> Maybe you can add a __NR_set_thread_area define in asm-generic/unsitd.h
> for tls used.

Yes, good point. I'll update the syscall list with this, and also check if more
syscalls have been addded.

	Arnd <><
