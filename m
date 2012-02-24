Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59889 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2BXPJp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 10:09:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] [PATCH] asm-generic/unistd.h: handle symbol prefixes in cond_syscall
Date: Fri, 24 Feb 2012 15:09:41 +0000
References: <4F47981F.4020305@imgtec.com> <201202241424.07319.arnd@arndb.de> <4F47A3F3.5030504@imgtec.com>
In-Reply-To: <4F47A3F3.5030504@imgtec.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201202241509.41809.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20120224150941.GiiTUx_lKbFLd74IpVwy7FC1q0-F21uoQg0X4OPzZP8@z>

On Friday 24 February 2012, James Hogan wrote:
> I've been looking at your initial comments for other architecture
> submissions and they've been very helpful, but if you do have any
> arch/metag specific suggestions I'd certainly welcome them.

I've had only a brief look. In general I recommend doing whatever
openrisc does, they are currently the best implementation we have.

In order to get the code merged, you will need to move probing
of on-chip buses to device trees rather than hardcoding the
platform devices, that is probably the largest amount of work
that is still needed unless you've done that already in a later
version.

Do you have a git tree or patch with the latest source code?
the only copy I could find is a 2.6.37 kernel inside of a huge
tarball.

	Arnd
