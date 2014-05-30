From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC 22/32] fs: convert simple fs to inode_time
Date: Fri, 30 May 2014 16:06:58 -0700
Message-ID: <20140530230658.GA25638@kroah.com>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
 <1401480116-1973111-23-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40406 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbaEaBIv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2014 21:08:51 -0400
Content-Disposition: inline
In-Reply-To: <1401480116-1973111-23-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>

On Fri, May 30, 2014 at 10:01:46PM +0200, Arnd Bergmann wrote:
> tty, usbgadgetfs, configfs and cramfs do not store inode timestamps
> permanently, but they use code that interacts with the VFS inode
> times. In order to change over VFS to a struct inode_time, we
> have to make trivial changes to these file systems as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Joel Becker <jlbec@evilplan.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
