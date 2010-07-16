From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/2] fcntl.h comment: Fix typo regarding O_SYNC
Date: Fri, 16 Jul 2010 11:00:30 +0100
Message-ID: <8130.1279274430@redhat.com>
References: <1279214957-10235-2-git-send-email-ted@tedp.id.au> <1279214957-10235-1-git-send-email-ted@tedp.id.au>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964895Ab0GPKAp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Jul 2010 06:00:45 -0400
In-Reply-To: <1279214957-10235-2-git-send-email-ted@tedp.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ted Percival <ted@midg3t.net>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Ted Percival <ted@tedp.id.au>


Ted Percival <ted@midg3t.net> wrote:

> +/* open/fcntl - O_SYNC is only implemented on block devices and on files
>     located on an ext2 file system */

Is this comment still true about the fact that, with respect to files, this is
only implemented on ext2?

David
