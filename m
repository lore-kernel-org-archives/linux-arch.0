Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab0IBPMz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Sep 2010 11:12:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20100902135438.GA23729@merkur.ravnborg.org>
References: <20100902135438.GA23729@merkur.ravnborg.org> <19747.1283422807@redhat.com> <20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select m68knommu contributions
Date: Thu, 02 Sep 2010 16:12:38 +0100
Message-ID: <24082.1283440358@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dhowells@redhat.com, gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20100902151238.q0VXyj9AAp-6yH7qimhKG41pdCtibyga8csTRygQmkM@z>

Sam Ravnborg <sam@ravnborg.org> wrote:

> This was exactly the reason why __uClinux__ was used in the first place.

That shouldn't be used in kernel headers.  It should be !CONFIG_MMU.

David
