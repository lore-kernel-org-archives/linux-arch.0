From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 17/31] arm64: System calls handling
Date: Mon, 10 Sep 2012 13:51:52 +0000
Message-ID: <201209101351.52902.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <201209071943.37184.arnd@arndb.de> <20120910095619.GA27042@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49857 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab2IJNv5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2012 09:51:57 -0400
In-Reply-To: <20120910095619.GA27042@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday 10 September 2012, Catalin Marinas wrote:
> Yes, I've seen these but since Al's patches are not in mainline, I don't
> want to add additional dependencies to the arm64 patches (currently
> based on 3.6-rc4). Once they get into mainline, I'll add a patch that
> converts arm64 to the generic functions above.
> 
> For kernel_execve(), I think I can simplify it further and not rely on
> Al's patches (similar to other architectures doing an SVC from kernel):

Hmm, I thought one of the reasons for Al to do his series was to discourage
people from doing syscalls from kernel space, but I may be misremembering
things. Al?

	Arnd
