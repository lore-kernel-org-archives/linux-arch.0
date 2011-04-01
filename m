From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] unicore32 fix: remove arch-specific futex support
Date: Fri, 1 Apr 2011 11:09:23 +0200
Message-ID: <201104011109.23966.arnd@arndb.de>
References: <01eb01cbeeb7$30390460$90ab0d20$@mprc.pku.edu.cn> <201103301440.03479.arnd@arndb.de> <004301cbef8c$b0bf0640$123d12c0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63256 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1DAJJ2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2011 05:09:28 -0400
In-Reply-To: <004301cbef8c$b0bf0640$123d12c0$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul Mundt' <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 31 March 2011, Guan Xuetao wrote:
> For cmpxchg, we have both system call and kuser_cmpxchg supports in old abi
> which are similar to arm.
> The performance of system call version is too poor,  so it could be only used for test.
> 

Let's forget about doing futex support for unicore32 then and use your original
patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>
