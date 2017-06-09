Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdFIJ1I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 05:27:08 -0400
Date: Fri, 9 Jun 2017 11:26:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] tty: add TIOCGPTPEER ioctl
Message-ID: <20170609092659.GA26933@kroah.com>
References: <20170603141515.9529-1-asarai@suse.de>
 <20170603141515.9529-3-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170603141515.9529-3-asarai@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <asarai@suse.de>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>
Message-ID: <20170609092659.AayXNp2ZADVynLHNlLsIBJcEKJ4N0YQPqLRYU9FPMCE@z>

On Sun, Jun 04, 2017 at 12:15:15AM +1000, Aleksa Sarai wrote:
> When opening the slave end of a PTY, it is not possible for userspace to
> safely ensure that /dev/pts/$num is actually a slave (in cases where the
> mount namespace in which devpts was mounted is controlled by an
> untrusted process). In addition, there are several unresolvable
> race conditions if userspace were to attempt to detect attacks through
> stat(2) and other similar methods [in addition it is not clear how
> userspace could detect attacks involving FUSE].
> 
> Resolve this by providing an interface for userpace to safely open the
> "peer" end of a PTY file descriptor by using the dentry cached by
> devpts. Since it is not possible to have an open master PTY without
> having its slave exposed in /dev/pts this interface is safe. This
> interface currently does not provide a way to get the master pty (since
> it is not clear whether such an interface is safe or even useful).
> 
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Valentin Rothberg <vrothberg@suse.com>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>

Is this going to be documented anywhere?  Is there a man page update
that also goes along with this?  What userspace program wants to use
this?

I'm not objecting to this, I just want to know that people will use
this, and that they can find out information about it if they want to.

thanks,

greg k-h
