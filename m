Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62615 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862AbZIDOgl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Sep 2009 10:36:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20090904142440.GM19494@bombadil.infradead.org>
References: <20090904142440.GM19494@bombadil.infradead.org> <20090903015707.GL19494@bombadil.infradead.org> <20090902072053.3578.69125.stgit@warthog.procyon.org.uk> <20090902072129.3578.81364.stgit@warthog.procyon.org.uk> <29063.1252047959@redhat.com>
Subject: Re: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all architectures [try #5]
Date: Fri, 04 Sep 2009 15:35:44 +0100
Message-ID: <32631.1252074944@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: dhowells@redhat.com, jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090904143544.aeDxq0WqiVpTpppTMxuF8oePlpBkVj0YERPDVtRM2iU@z>

Kyle McMartin <kyle@mcmartin.ca> wrote:

> I don't think this depends on the previous patches in the series... it
> would probably be easiest if I just merged it with the rest of them
> though...

The problem I've got is that patch 9/9 depends on this change, but James
doesn't have your patch in his tree.

David
