From: Michael Kerrisk <mtk.manpages@googlemail.com>
Subject: Re: [PATCH 1/1] x86: syscalls: sys_setrlimit64/sys_getrlimit64 calls
 to provide FSIZE  limits > 2^32-1
Date: Tue, 27 Jan 2009 01:46:23 +0100
Message-ID: <497E595F.2010708@gmail.com>
References: <200901231759.n0NHxKA3009104@eng-pool-55.spikesource.com> <200901262004.16364.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:8108 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZA0AqQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jan 2009 19:46:16 -0500
In-Reply-To: <200901262004.16364.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: narendramind@spikesource.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, torvalds@osdl.org, linux-abi@vger.kernel.org, linux-arch@vger.kernel.org

Arnd Bergmann wrote:
> On Friday 23 January 2009, narendramind@spikesource.com wrote:
>>   The solution to this problem would require new setrlimit64() and 
>>   getrlimit64() system calls on x86, and the existing 32-bit system calls 
>>   would need to be retained so that existing binaries would still run.
> 
> When adding new syscalls, please Cc: linux-abi@vger.kernel.org and

Arnd -- I think you meant linux-api, not linux-abi.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
