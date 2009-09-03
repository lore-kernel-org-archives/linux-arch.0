From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all
	architectures [try #5]
Date: Wed, 2 Sep 2009 21:57:07 -0400
Message-ID: <20090903015707.GL19494@bombadil.infradead.org>
References: <20090902072053.3578.69125.stgit@warthog.procyon.org.uk> <20090902072129.3578.81364.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:56133 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbZICB5P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2009 21:57:15 -0400
Content-Disposition: inline
In-Reply-To: <20090902072129.3578.81364.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Sep 02, 2009 at 08:21:29AM +0100, David Howells wrote:
>  arch/parisc/include/asm/thread_info.h |    4 +++-
>  arch/parisc/kernel/entry.S            |    2 +-
>  arch/parisc/kernel/signal.c           |    5 +++++
>  18 files changed, 64 insertions(+), 6 deletions(-)

Please drop these bits. I have done similar for .32 in the tracehook
branch.

regards, Kyle
