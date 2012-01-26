From: stian@nixia.no
Subject: Re: [uml-devel] /sys/class/tty/tty0/active?
Date: Thu, 26 Jan 2012 23:11:04 +0100 (CET)
Message-ID: <58311.79.160.186.248.1327615864.squirrel@www.nlc.no>
References: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.powertech.no ([195.159.0.145]:54058 "EHLO
	smtp1.powertech.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab2AZWmA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2012 17:42:00 -0500
In-Reply-To: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Greg KH <gregkh@suse.de>, user-mode-linux-devel@lists.sourceforge.net

> Hi!
>
> systemd goes nuts on UML.
> While hunting down all issues I found out that systemd wants to read from
> /sys/class/tty/tty0/active.

Kernel version?
http://comments.gmane.org/gmane.comp.sysutils.systemd.devel/3079 indicates
that the given file appears in 2.6.37

Stian Skjelstad
