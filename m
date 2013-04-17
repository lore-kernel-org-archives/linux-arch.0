From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/28] proc: Move some bits from linux/proc_fs.h to
 linux/{of.h, signal.h, tty.h} [RFC]
Date: Tue, 16 Apr 2013 17:57:53 -0700
Message-ID: <20130417005753.GB11541@kroah.com>
References: <20130416182550.27773.89310.stgit@warthog.procyon.org.uk>
 <20130416182626.27773.48524.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130416182626.27773.48524.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, Jri Slaby <jslaby@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 16, 2013 at 07:26:26PM +0100, David Howells wrote:
> Move some bits from linux/proc_fs.h to linux/of.h, signal.h and tty.h.
> 
> Also move proc_tty_init() and proc_device_tree_init() to fs/proc/internal.h as
> they're internal to procfs.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: devicetree-discuss@lists.ozlabs.org
> cc: linux-arch@vger.kernel.org
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: Jri Slaby <jslaby@suse.cz>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
