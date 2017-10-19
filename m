Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdJSHeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2017 03:34:11 -0400
Date: Thu, 19 Oct 2017 09:34:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4][PoC][RFC] sched: Allow to get() and put() signal
 struct
Message-ID: <20171019073418.GC20787@kroah.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
 <CGME20171018203328epcas2p4bdcc3650d1c0f0add143488792243932@epcas2p4.samsung.com>
 <20171018203230.29871-2-k.opasiak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018203230.29871-2-k.opasiak@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: viro@zeniv.linux.org.uk, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com
Message-ID: <20171019073418.fUREsAmT3HUsJDwQkzUcvhO0Ny9TnLto5T2zf14FFk4@z>

On Wed, Oct 18, 2017 at 10:32:27PM +0200, Krzysztof Opasiak wrote:
> Allow to get() and put() signal struct from different
> parts of kernel core, not only from signal.c.

That says what this does, but not _why_.  Who would ever want to have
access to these internal-only functions?

thanks,

greg k-h
