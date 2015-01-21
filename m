From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/16] Revert h8300 archtecture
Date: Wed, 21 Jan 2015 19:36:21 +0000
Message-ID: <32417.1421868981@warthog.procyon.org.uk>
References: <87mw5ckpsz.wl-ysato@users.sourceforge.jp> <87bnlsvjce.wl-ysato@users.sourceforge.jp> <19300.1421838158@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbbAUTga (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Jan 2015 14:36:30 -0500
In-Reply-To: <87mw5ckpsz.wl-ysato@users.sourceforge.jp>
Content-ID: <32416.1421868981.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org

Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

> I using binutils-2.25 and gcc-4.9.2.

Excellent!  I maintain the cross-binutils and cross-gcc rpm sets for Fedora.
I've been compiling h8300 with h8300-elf.  Should I be using h8300-linux
instead?

David
