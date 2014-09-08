From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 00/29] nios2 Linux kernel port
Date: Mon, 08 Sep 2014 13:13:37 +0100
Message-ID: <18039.1410178417@warthog.procyon.org.uk>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbaIHMNt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Sep 2014 08:13:49 -0400
In-Reply-To: <1410168160-3624-1-git-send-email-lftan@altera.com>
Content-ID: <18038.1410178417.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

Ley Foon Tan <lftan@altera.com> wrote:

> Nios2 GCC port is in mainline and will be in the FSF 4.9 release.
> 
> The patchset are based on v3.17-rc3 and can also be found in the following git tree:
> git://git.rocketboards.org/linux-socfpga-next.git  nios2-upstream

Fedora carries a nios2 cross-compiler from F19 onwards:

warthog>yum list \*nios2\*
Loaded plugins: auto-update-debuginfo
Installed Packages
binutils-nios2-linux-gnu.x86_64          2.24-5.fc20            @updates-testing
gcc-c++-nios2-linux-gnu.x86_64           4.9.1-1.fc20           @updates-testing
gcc-nios2-linux-gnu.x86_64               4.9.1-1.fc20           @updates-testing

David
