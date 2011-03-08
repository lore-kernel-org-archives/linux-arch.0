Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12760 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab1CHQhN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Mar 2011 11:37:13 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20110308152518.074d0996@lxorguk.ukuu.org.uk>
References: <20110308152518.074d0996@lxorguk.ukuu.org.uk> <20110307160042.2ddc8e65@lxorguk.ukuu.org.uk> <20110307150208.28218.89348.stgit@warthog.procyon.org.uk> <20110307150218.28218.84916.stgit@warthog.procyon.org.uk> <14977.1299596999@redhat.com>
Subject: Re: [PATCH 2/2] Define ENONAMESERVICE and ENAMEUNKNOWN to indicate name service errors
Date: Tue, 08 Mar 2011 16:37:01 +0000
Message-ID: <17429.1299602221@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@linux-nfs.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110308163701.g_WX7if32wThqm8bi0HkoO5BbOj2D63KgswvdUPirx0@z>

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> I was wondering if at least there was some co-ordination going on so that
> functions like perror() produced sensible answers. Otherwise it's
> debatable if its actually an improvement for the poor end user ?

Fair point.  That's why I cc'd the messages to linux-api@, but I'm not sure who
actually reads it, besides Michael Kerrisk.  I guess it's probably a good idea
to wave my suggestions on the glibc list at least.

David
