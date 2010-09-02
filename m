From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select m68knommu contributions
Date: Thu, 02 Sep 2010 16:11:52 +0100
Message-ID: <24053.1283440312@redhat.com>
References: <m38w3kns4r.fsf@hase.home> <19747.1283422807@redhat.com> <20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808Ab0IBPMI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Sep 2010 11:12:08 -0400
In-Reply-To: <m38w3kns4r.fsf@hase.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@redhat.com>
Cc: dhowells@redhat.com, gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Andreas Schwab <schwab@redhat.com> wrote:

> > Use CONFIG_MMU not __uClinux__ to select m68knommu contributions as
> > nothing in the arch defines __uClinux__ for the build.
> 
> You are using the wrong compiler.

It's the only m68k compiler that I've got.

David
