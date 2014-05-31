From: Vyacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [RFC 24/32] hfs, hfsplus: convert to struct inode_time
Date: Sat, 31 May 2014 18:23:49 +0400
Message-ID: <1401546229.2413.2.camel@slavad-CELSIUS-H720>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
	 <1401480116-1973111-25-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:38674 "HELO
	gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756411AbaEaOYV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 31 May 2014 10:24:21 -0400
In-Reply-To: <1401480116-1973111-25-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org

Hi Arnd,

On Fri, 2014-05-30 at 22:01 +0200, Arnd Bergmann wrote:
> hfs uses 32-bit integers based at 1904 for inode timestamps, which will
> only work until 2040, but the VFS uses struct timespec for timestamps,
> which expires even earlier in 2038 on 32-bit CPUs.
> 
> This gets us one small step closer to lifting the VFS limit by using
> struct inode_time in logfs.
> 

I think you meant hfs/hfsplus here. I suppose that mentioning the logfs
is simple misspelling.

Thanks,
Vyacheslav Dubeyko.
