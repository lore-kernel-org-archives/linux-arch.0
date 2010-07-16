From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 2/2] fcntl.h comment: Fix typo regarding O_SYNC
Date: Fri, 16 Jul 2010 12:56:39 +0100
Message-ID: <20100716115639.GA16707@shareable.org>
References: <1279214957-10235-2-git-send-email-ted@tedp.id.au> <1279214957-10235-1-git-send-email-ted@tedp.id.au> <8130.1279274430@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:42945 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049Ab0GPL4w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2010 07:56:52 -0400
Content-Disposition: inline
In-Reply-To: <8130.1279274430@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Ted Percival <ted@midg3t.net>, linux-arch@vger.kernel.org, Ted Percival <ted@tedp.id.au>

David Howells wrote:
> 
> Ted Percival <ted@midg3t.net> wrote:
> 
> > +/* open/fcntl - O_SYNC is only implemented on block devices and on files
> >     located on an ext2 file system */
> 
> Is this comment still true about the fact that, with respect to files, this is
> only implemented on ext2?

No, it isn't.

-- Jamie
