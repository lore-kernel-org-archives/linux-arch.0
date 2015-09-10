From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 10/13] Hide USE_WCACHING behind #ifdef __KERNEL__
Date: Thu, 10 Sep 2015 12:12:59 +0100
Message-ID: <18082.1441883579@warthog.procyon.org.uk>
References: <1441832902-28993-11-git-send-email-palmer@dabbelt.com> <2644177.lVCYzIBfPW@wuerfel> <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49843 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbbIJLNH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Sep 2015 07:13:07 -0400
In-Reply-To: <1441832902-28993-11-git-send-email-palmer@dabbelt.com>
Content-ID: <18081.1441883579.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dhowells@redhat.com, arnd@arndb.de, 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> I don't think this was ever intended to be exposed to userspace.

Then it should be in include/linux/pktcdvd.h

David
