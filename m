Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54266 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120Ab3DQA6F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 20:58:05 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so573399pdj.27
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2013 17:58:03 -0700 (PDT)
Date: Tue, 16 Apr 2013 17:57:53 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/28] proc: Move some bits from linux/proc_fs.h to
 linux/{of.h, signal.h, tty.h} [RFC]
Message-ID: <20130417005753.GB11541@kroah.com>
References: <20130416182550.27773.89310.stgit@warthog.procyon.org.uk>
 <20130416182626.27773.48524.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130416182626.27773.48524.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, Jri Slaby <jslaby@suse.cz>
Message-ID: <20130417005753.pvUt9xvhDwM6ofVSp3Uo9QZ2oSf_Fi4RkwlCg4ljQ70@z>

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
