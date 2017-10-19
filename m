From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4][PoC][RFC] sched: Allow to get() and put() signal
 struct
Date: Thu, 19 Oct 2017 09:34:18 +0200
Message-ID: <20171019073418.GC20787@kroah.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
 <CGME20171018203328epcas2p4bdcc3650d1c0f0add143488792243932@epcas2p4.samsung.com>
 <20171018203230.29871-2-k.opasiak@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171018203230.29871-2-k.opasiak@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: viro@zeniv.linux.org.uk, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 18, 2017 at 10:32:27PM +0200, Krzysztof Opasiak wrote:
> Allow to get() and put() signal struct from different
> parts of kernel core, not only from signal.c.

That says what this does, but not _why_.  Who would ever want to have
access to these internal-only functions?

thanks,

greg k-h
