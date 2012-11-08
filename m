From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [RFC PATCH v1 14/40] metag: Ptrace
Date: Thu, 8 Nov 2012 08:17:20 +0100
Message-ID: <CACM3HyFrzGXh0QMnw0OdxKu6PFzFacJma=0WH9LEYj3SCa=cJA@mail.gmail.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
	<1351700061-7203-15-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61359 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab2KHHRV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Nov 2012 02:17:21 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so1010441bkc.19
        for <linux-arch@vger.kernel.org>; Wed, 07 Nov 2012 23:17:20 -0800 (PST)
In-Reply-To: <1351700061-7203-15-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On 31 October 2012 17:13, James Hogan <james.hogan@imgtec.com> wrote:
> We use the non-generic interface at the moment (exposing the TBX context
> structures to userland), pending conversion to the generic ptrace
> interface.
>

Hi James,

Comment 1, as you already mentioned in the blurb, is to use the
generic ptrace interface... a lot of your ptrace functions aren't need
anymore.
Comment 2, is to avoid exporting the struct pt_regs to userspace.  GDB
should be using regsets for accessing the current context for new
architectures and doesn't need to know about the pt_regs layout
anymore.  Not exporting pt_regs gains you the flexibility to optimize
context saving in the future if you figure out a better (e.g. cache
friendlier) way of saving your registers at exception time.

/Jonas
