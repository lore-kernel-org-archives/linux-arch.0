Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbbIJLNm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Sep 2015 07:13:42 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1441832902-28993-12-git-send-email-palmer@dabbelt.com>
References: <1441832902-28993-12-git-send-email-palmer@dabbelt.com> <2644177.lVCYzIBfPW@wuerfel> <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Subject: Re: [PATCH 11/13] Hide MAX_RAW_MINORS behind #ifdef __KERNEL__
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18102.1441883614.1@warthog.procyon.org.uk>
Date: Thu, 10 Sep 2015 12:13:34 +0100
Message-ID: <18103.1441883614@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dhowells@redhat.com, arnd@arndb.de, 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org
Message-ID: <20150910111334._ZvBV-GkdEcbASEtVD-w0Cktaccyjm9EqtzRFZKkrzc@z>

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> I don't think this was ever meant to be exposed to userspace.

Then it should be in include/linux/raw.h

David
